function [rho,theta]=ImgSH(img,res,str)
%[rho,theta]=ImgSH(img)
% Standard Hough transform for a 2D image
% return the best fit line 
% RES: resolution, represented by [ang, dis]
%   , where the units are degree and pixels
% IMG: is 2D matrix in double precision. Each 
% entry of IMG must be either 0 or 1.
%
% Zhen Song zhensong@cc.usu.edu

Deg2Rad=pi/180;

[row,col]=size(img);
% find the size of the image

AngRes=res(1)*Deg2Rad; 
%Angle resolution in rad
AngNum=round(pi/AngRes);
% AngNum is the number of grids in x direction
% of the accumulation space
% process from 0 to pi and eliminte those 
%   with minus rho
DisNum=res(2);
DisRes=(row+col)/DisNum;
%xmax = col, ymax=row
% since rho=x*cos(theta)+y*sin(theta)
% rhomax<xmax+ymax
% Actually, let t=y/x, then (in LaTeX format)
% $rho_{max}\leq x \sqrt{\frac{1}{1+t^2}}+y \sqrt{\frac{t^2}{1+t^2}}$
% Didn't use this more accurate, but complex equation
AccumSp=zeros(AngNum,DisNum);

AccumAng=0:AngRes:2*pi-AngRes;
[Indx,Indy]=find(img==1);
RhoMat=Indx*cos(AccumAng)+Indy*sin(AccumAng);

RhoMat=round(RhoMat./DisRes);
%RhoMat: for each row, it stores the distance w.r.t each angle
% Its row number is the number of nonzero points
% The value of RhoMat is the pixel offsets

ptnum=size(RhoMat,1);
for cnt=1:ptnum
    %For each point, update the accumulate space 
    line=RhoMat(cnt,:);
    AccumSp(line,:)=AccumSp(line,:)+1;
end
[indy,indx]=find(AccumSp==max(AccumSp));
%if have more than one max value
% just get the first one
indx=indx(1);
indy=indy(1);

theta=indx*AngRes;
rho=indy*DisRes;

%if rho is minus, convert it to positive
if rho<0
    theta=theta+pi;
    rho=abs(rho);
end

if strcmp(str,'show')
    %show accumulate space 
    figure(1);
    Imshow(AccumSp);
    title('Accumulate Space');
end
return;