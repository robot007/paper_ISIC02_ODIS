//*******************************************
//	Fits.h
//	Circle/Ellipse Fit lib
//
//	Zhen Song Aug 8, 2001
//	zhensong@cc.usu.edu
// check http://cc.usu.edu/~zhensong/fits/fitbrief.zip for latest version
//*******************************************

#ifndef Fit_h_ODIS_CSOIS_USU_2001
#define Fit_h_ODIS_CSOIS_USU_2001 1

#define WANT_STREAM                  // include.h will get stream fns
#define WANT_MATH                    // include.h will get math fns
                                     // newmatap.h will get include.h

#include "newmatap.h"                // need matrix applications
#include "newmatio.h"                // need matrix output routines

#ifdef use_namespace
using namespace NEWMAT;              // access NEWMAT namespace
#endif



#include <math.h>
#include <stdio.h>
#include <errno.h>
#include <typeinfo.h>
#include <string.h>

typedef struct Circle{
	double x0, y0; //(x-x0)^2+(y-y0)^2=r^2
	double Cx, Cy, C; //x^2+Cx x+ y^2+ Cy y+ C=0
	double rho, theta; //polar cordination
	double r;
	double err; //fitting error
}circle;

typedef struct Ellipse{
	double Cx2, Cxy, Cy2, Cx, Cy, C; 
	//Cx2 * x^2 + Cxy * x*y + Cy2 * y^2 + Cx * x + Cy * y +C =0
	double x0, y0, rx,ry,theta;
	// /over{(x-x_0)^2}{r_1} + /over{ (y-y_0)^2}{r_2} = 0,
	// and rotate /theta degree.
	double err;//fitting error
}ellipse;

int AlgCircle(const Matrix & , circle & );
int mldivide(Matrix &, const Matrix &, const Matrix &);
int KrCircle(const Matrix &, circle &);
int FitEllipse(Matrix &, ellipse & );
void SolveEllipse(ellipse &el);

//Matrix DotProduct(Matrix , Matrix );
Matrix DotProduct(Matrix , Matrix );
Matrix DotProduct(Matrix , Real );
Matrix DotProduct( Real , Matrix );

Matrix DotDiv(Matrix , Matrix );
Matrix DotDiv(Matrix , Real );
Matrix DotDiv( Real  , Matrix );

#define MAX_CIRCLE_AVE_ERR (0.1)
#endif