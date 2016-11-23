function [t,r]=fitline(pt1, pt2)

    abs(Pt1(1)-Pt2(1))<1e-6
                alpha=pi/2; % do not distinguish +-pi/2, since there is no direction of the line
            else 
                alpha=atan( (dat(cnt1,2)-dat(cnt2,2))/(dat(cnt1,1)-dat(cnt2,1)) );
            end
            rho0=dat(cnt1,1)*cos(alpha-pi/2) + dat(cnt1,2)*sin(alpha-pi/2);
            Theta=alpha-sign(rho0)*pi/2;
            CellTheta=floor(Theta/ResTheta)*ResTheta;
            Rho=abs(rho0); % dat(cnt2,1)*cos(Theta)+dat(cnt2,2)*sin(Theta);
            CellRho=floor(Rho/ResRho)*ResRho;
            