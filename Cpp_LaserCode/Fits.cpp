//*******************************************
//	Fits.cpp
//	Circle/Ellipse Fit lib
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************







#include "Fits.h"


//*******************************************
//	Fits.cpp
//	AlgCircle( ) ver
//Algebric Circle Fit
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
int AlgCircle(const Matrix & X, circle & Cir)
{

//  B  = [ X(:,1).^2+X(:,2).^2  X(:,1)  X(:,2) ones(size(X(:,1)))];
//  [U S V]= svd(B);
//  u = V(:,4); a = u(1); b =[u(2); u(3)]; c = u(4);
//  z = -b/2/a; r = sqrt(norm(z)^2 - c/a);
	const double pi=3.141592653589793238462643383279;
	int Row, Col;
	double a;
	int i;
	if ((X.Ncols( ) != 2) || (X.Nrows( ) <= 2)){
		return -2;
		// format incorrect, or insufficent input data.
	}

	Try{

		Row=X.Nrows( );
		Col=X.Ncols( );
		ColumnVector col1(Row); 
		ColumnVector col2(Row);
		ColumnVector col3(Row);
		ColumnVector col4(Row);
		col2 << X.Column (2);
		col3 << X.Column (1);
		for(i=0;i<Row;i++){
			col1.element(i)=col2.element(i)*col2.element(i)+col3.element(i)*col3.element(i);
			col4.element(i)=1.0;
		}
		Matrix B(Row, 4), U(Row,4), V(4,4);
		DiagonalMatrix D(4);

		B.Column (1)<<col1;
		B.Column (2)<<col2;
		B.Column (3)<<col3;
		B.Column (4)<<col4;

		SVD(B, D, U, V);

		ColumnVector u(Row);
		double fMin=D(1,1);
		int nMinInd=1;
		for(i=2;i<=Row && i<= 4; i++){
			if (fMin>D(i,i)){
				fMin=D(i,i); //MIN(D(i,i),min)
				nMinInd=i;
			}
		}
		//so far, SVD has problem with sorting. 
		//So need to find the vector associate with minium singularity value 
		
		u << V.Column (nMinInd);

		a=u(1);
		ColumnVector b(2);
		b(1)=u(2);
		b(2)=u(3);



		double c=u(4);
		Cir.x0=-b(2)/2/a; //odis cordination 
		Cir.y0=-b(1)/2/a;
		Cir.r=sqrt(Cir.x0*Cir.x0+Cir.y0*Cir.y0-c/a);
		Cir.Cx=-2.0*Cir.x0;
		Cir.Cy=-2.0*Cir.y0;
		Cir.C =Cir.x0*Cir.x0 + Cir.y0*Cir.y0 - Cir.r*Cir.r;
		Cir.rho=sqrt(Cir.x0*Cir.x0 + Cir.y0*Cir.y0 );

		if (Cir.x0==0){
			if(Cir.y0>0){
				Cir.theta=pi/2;
			}
			else if(Cir.y0<0){
				Cir.theta=-pi/2;
			}
			else{ //Cir.y0=0
				Cir.theta=0;
				return -2;
			}
		}
		else{
			Cir.theta=atan2(Cir.y0,Cir.x0);
		}
		//calculate error : sum(abs(del_r))
		double ErrSum=0;
		double x,y;
		for(i=1; i<=Row; i++){
			x=X(i,1);
			y=X(i,2);
			ErrSum+=
				fabs(sqrt( pow( (x-Cir.x0) ,2)+ pow((y-Cir.y0 ),2) )-Cir.r);
		}
		Cir.err = ErrSum;

		return 0;
	}
	CatchAll { 
		cout << Exception::what(); 
		return -1;
	}

}

//*******************************************
//	Fits.cpp
//	mldivide( ) 
//Mimic Matlab function ``mldivide''
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
int mldivide(Matrix &Ans,const Matrix &LfIn, const Matrix &RtIn)
{
	Matrix M, Lf, Rt;
	UpperTriangularMatrix U;
	Lf=LfIn;
	Rt=RtIn;
	int nRow, nCol, nRank;
	nCol=Lf.Ncols ( );
	nRow=Lf.Nrows ( );
	Try{
		nRank=Lf.Rank ( );
		if (nRank<nCol && nRank<nRow){
			Throw(Exception("Rank deficient, don't know how to do mldivide") );
		} //But matlab can give a answer. So far, I don't know how it does.
		QRZ(Lf, U);
		QRZ(Lf, Rt, M);
		Ans=U.i( )*M;
	}
	CatchAll { 
		cout << Exception::what()<<endl; 
		return -1;
	}
	return 0;
}

//*******************************************
//	Fits.cpp
//	DotProduct( ) 
// Dot Product of Matrices
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotProduct(Matrix Lf, Matrix Rt)
{
	int RowL=Lf.Nrows( );
	int RowR=Rt.Nrows( );
	int ColL=Lf.Ncols( );
	int ColR=Rt.Ncols( );
	Matrix Ans(RowL,ColL); 
	Try{
		if(RowL==RowR && ColL==ColR ){  //do dot product only if dimension matches.
			for(int i=1; i<=RowL; i++){
				for(int j=1; j<=ColL; j++){
					Ans(i,j)=Lf(i,j)*Rt(i,j);
				}
			}
		}
		else{
			Ans=0;
			Throw(Exception("To use dot production,Matrix dimensions must agree.\n"));
		}
	}
	CatchAll{
		cout << Exception::what(); 
	}
	return Ans;
}
//*******************************************
//	Fits.cpp
//	DotProduct( ) 
// Dot Product of Matrix And Array
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotProduct(Matrix Lf, Real fRt)
{
	int RowL=Lf.Nrows( );
	int ColL=Lf.Nrows( );

	Matrix Ans(RowL, ColL);
	Ans=Lf*fRt;
	return Ans;
}
//*******************************************
//	Fits.cpp
//	DotProduct( ) 
// Dot Product of Matrix And Array
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotProduct( Real fLf, Matrix Rt)
{
	int RowR=Rt.Nrows( );
	int ColR=Rt.Nrows( );

	Matrix Ans(RowR, ColR);
	Ans=Rt*fLf;
	return Ans;
}

//*******************************************
//	Fits.cpp
//	DotDiv( ) 
// Dot Divide of Matrices
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotDiv(Matrix Lf, Matrix Rt)
{
	int RowL=Lf.Nrows( );
	int RowR=Rt.Nrows( );
	int ColL=Lf.Nrows( );
	int ColR=Rt.Nrows( );
	Matrix Ans(RowL,ColL); 
	Try{
		if(RowL==RowR && ColL==ColR ){  //do dot product only if dimension matches.
			
			for(int i=1; i<=RowL; i++){
				for(int j=1; j<=ColL; j++){
					if(fabs(Rt(i,j))<SMALLEST_POSITIVE){
						Throw(Exception("divided by zero"));
						Ans(i,j)=Lf(i,j)/SMALLEST_POSITIVE;
					}
					else{
						Ans(i,j)=Lf(i,j)/Rt(i,j);
					}
				}
			}
		}
		else{
			Ans=0;
			Throw(Exception("To use dot production,Matrix dimensions must agree.\n"));
		}
	}

	CatchAll{
		cout << Exception::what(); 
	}
	return Ans;

}

//*******************************************
//	Fits.cpp
//	DotDiv( ) 
// Dot Divide of Matrix And Array
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotDiv(Matrix Lf, Real fRt)
{
	int RowL=Lf.Nrows( );
	int ColL=Lf.Nrows( );

	Matrix Ans(RowL, ColL);
	if(fabs(fRt)<SMALLEST_POSITIVE){
		Throw(Exception("divided by zero"));
		Ans=Lf/SMALLEST_POSITIVE;
	}
	else{
		Ans=Lf/fRt;
	}
	return Ans;
}

//*******************************************
//	Fits.cpp
//	DotDiv( ) 
// Dot Divide of Matrix And Array
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
Matrix DotDiv( Real fLf, Matrix Rt)
{
	int RowR=Rt.Nrows( );
	int ColR=Rt.Nrows( );

	Matrix Ans(RowR, ColR);
	for(int i=1;i<=RowR; i++){
		for(int j=1; j<=ColR; j++){
			if(fabs(Rt(i,j))<SMALLEST_POSITIVE){
				Throw(Exception("divided by zero") );
				Ans(i,j)=fLf/SMALLEST_POSITIVE;
			}
			else{
				Ans(i,j)=fLf/Rt(i,j);
			}
		}
	}
	return Ans;
}

//*******************************************
//	Fits.cpp
//	KrCircle( ) 
// Circle Fit With Known Radii
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************

int KrCircle(const Matrix &Mt, circle &Cir)
{
// r=rstar;   % rstar is the known radius
// u = [z(1), z(2) ]'    % Starting values
// h = u;
// it=0;
// while norm(h)>norm(u)*1e-6,
//    a = u(1)-X(:,1); b = u(2)-X(:,2);
//    fak = sqrt(a.*a + b.*b);
//    J = [a./fak b./fak ];  
//    f = fak - rstar;
//    h = -J\f;
//    u = u + h;
//    it=it+1;
//  end;
//  z = u(1:2);
//it
	const double pi=3.141592653589793238462643383279;

	int Row, Col;
	int i,ret;
	double rstart=Cir.r;

	Row=Mt.Nrows( );
	Col=Mt.Ncols( );
	if ((Col != 2) || (Row <= 2)){
		return -2;
		// format incorrect, or insufficent input data.
	}
	//do AlgCircle fit first
	circle CirAlg;
	AlgCircle(Mt, CirAlg);
	if (CirAlg.err/Mt.Ncols( )> MAX_CIRCLE_AVE_ERR ){
		Throw(Exception("Input might not be a circle, can't do KrCircle fit\n"));
		return -2;
		// input data are not circle
	}

	int it=0;
	Real u[]={CirAlg.x0, CirAlg.y0}; //get initial origin position
	Real h[]={CirAlg.x0, CirAlg.y0};

	Matrix Ax, Ay, U(2,1),H(2,1),FakeRad(Row,1), Jxy(Row,2),FdelR;
	U<<u; H<<h;
	
	ColumnVector MtX, MtY;
	MtX=Mt.Column(1);
	MtY=Mt.Column(2);
	Try{
		while(sqrt(pow(H(1,1),2)+pow(H(2,1),2)) > sqrt(pow(U(1,1),2)+pow(U(2,1),2)) * 1e-6){
			Ax=U(1,1)-MtX;
			Ay=U(2,1)-MtY;
			for(i=1;i<=Row;i++){
				FakeRad(i,1)=sqrt(Ax(i,1)*Ax(i,1)+Ay(i,1)*Ay(i,1));
				Jxy(i,1)=Ax(i,1)/FakeRad(i,1);
				Jxy(i,2)=Ay(i,1)/FakeRad(i,1);
			}

			FdelR=FakeRad-rstart;
			if( (ret=mldivide(H,-Jxy,FdelR)) !=0){
				return ret;
				//can't find mldivide solution
			}
			U+=H;
			it++; //increase iteration counter
		}
	}
	CatchAll{
		cout<<Exception::what( );
		return -1;
	}
	Cir.x0= U(2,1);
	Cir.y0= U(1,1);
	Cir.r= rstart;
	Cir.Cx=-2.0*Cir.x0;
	Cir.Cy=-2.0*Cir.y0;
	Cir.C =Cir.x0*Cir.x0 + Cir.y0*Cir.y0 - Cir.r*Cir.r;
	Cir.rho=sqrt(Cir.x0*Cir.x0 + Cir.y0*Cir.y0 );

	if (Cir.x0==0){
		if(Cir.y0>0){
			Cir.theta=pi/2;
		}
		else if(Cir.y0<0){
			Cir.theta=-pi/2;
		}
		else{ //Cir.y0==0 && Cir.x0==0
			Cir.theta=0;
			return -2;
		}
	}
	else{
		Cir.theta=atan2(Cir.y0,Cir.x0);
	}
	double ErrSum=0;
	double x,y;
	for(i=1; i<=Row; i++){
		x=Mt(i,1);
		y=Mt(i,2);
		ErrSum+=
			fabs(sqrt( pow( (x-Cir.x0) ,2)+ pow((y-Cir.y0 ),2) )-Cir.r);
	}
	Cir.err = ErrSum;
	return it;
}

//*******************************************
//	Fits.cpp
//	FitEllipse( ) 
// Ellipse Fit 
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************

int FitEllipse(Matrix & Ellipse, ellipse & el)
{
	int Col, Row;
	int i;
	Row=Ellipse.Nrows( );
	Col=Ellipse.Ncols( );
	if (Col!=2  || Row<=4){
		return -2;
		//not [x, y] or data are not enough
	}
	Matrix X(Row,1), Y(Row,1) , One(Row,1); 
	Matrix D(Row,6); //ellipse has 6 parameters
	Try{
		X<<Ellipse.Column (1);
		Y<<Ellipse.Column (2);
		for(i=1;i<=Row;i++)
			One(i,1)=1;
		Matrix Ans;
		Ans<<DotProduct(X,Y);

		D.Column(1) << DotProduct(X,X);
		D.Column(2) << DotProduct(X,Y);
		D.Column(3) << DotProduct(Y,Y);
		D.Column(4) << X;
		D.Column(5) << Y;
		D.Column(6) << One;
		DiagonalMatrix S;
		Matrix V(6,6), U(Row, 6);
	
		SVD(D, S, U, V);
	
		double fMin=S(1,1);
		int nMinInd=1;
		for(i=2;i<=Row && i<= 6; i++){
			if (fMin>S(i,i)){
				fMin=S(i,i); //MIN(S(i,i),min)
				nMinInd=i;
			}
		}
	
		el.Cx2=V(1,nMinInd);
		el.Cxy=V(2,nMinInd);
		el.Cy2=V(3,nMinInd);
		el.Cx= V(4,nMinInd);
		el.Cy= V(5,nMinInd);
		el.C = V(6,nMinInd);
			
		SolveEllipse(el);
		double error=0;
		for ( i=1 ;i <=Row; i++){
			error+=fabs(el.Cx2*X(i,1)*X(i,1) + el.Cxy*X(i,1)*Y(i,1) + el.Cy2 *Y(i,1)*Y(i,1)
				+ el.Cx * X(i,1) + el.Cy* Y(i,1) +el.C);
		}
		el.err = error;
	}
	CatchAll{
		cout << Exception::what(); 
	}

	return 0;
}

	
//*******************************************
//	Fits.cpp
//	SolveEllipse( ) 
// Transfer Amongs Differnt Representations of Ellipse 
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************
void SolveEllipse(ellipse &el)
{
/*	    % get ellipse orientation
        theta = atan2(a(2),a(1)-a(3))/2;

        % get scaled major/minor axes
        ct = cos(theta);
        st = sin(theta);
        ap = a(1)*ct*ct + a(2)*ct*st + a(3)*st*st;
        cp = a(1)*st*st - a(2)*ct*st + a(3)*ct*ct;

        % get translations
        T = [[a(1) a(2)/2]' [a(2)/2 a(3)]'];
        t = -inv(2*T)*[a(4) a(5)]';
        cx = t(1);
        cy = t(2);

        % get scale factor
        val = t'*T*t;
        scale = 1 / (val- a(6))

        r1 = 1/sqrt(scale*ap);
        r2 = 1/sqrt(scale*cp);
        v = [r1 r2 cx cy theta]';
*/
	double theta=atan2(el.Cxy, el.Cx2-el.Cy2)/2;
	double ct=cos(theta), st=sin(theta);
	double ap=el.Cx2*ct*ct + el.Cxy*ct *st + el.Cy2*st*st;
	double cp=el.Cx2*st*st - el.Cxy*ct *st + el.Cy2*ct*ct;
	Matrix T(2,2);
	T<<el.Cx2 <<   el.Cxy/2 
	 <<el.Cxy/2 << el.Cy2;
	Matrix t, tmp(2,1);
	tmp<<el.Cx<<el.Cy;
	t=-(2*T).i( )*tmp;
	double cx=t(1,1);
	double cy=t(2,1);
	Matrix Mval;
	Mval=t.t( )*T*t;
	double val=Mval(1,1);
	double scale;
	scale = 1.0/(val-el.C);
	double r1=1/sqrt(scale*ap);
	double r2=1/sqrt(scale*cp);
	el.x0 = cx;
	el.y0 = cy;
	el.rx = r1;
	el.ry = r2;
	el.theta = theta;
}
