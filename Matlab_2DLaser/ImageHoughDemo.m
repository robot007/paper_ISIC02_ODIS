%ImageHoughDemo: read two BMP (Line.bmp and Circle.bmp)file from harddisk
% and detect them by standard and circular hough transform

linebmp=imread('Line','bmp');
[row,col]=size(linebmp);
DlineBmp=-double(linebmp)+1; 
%change to double and do processing
[rho,theta]=ImgSH(DlineBmp,[1,180],'show');

[indy,indx]=find(Dlinebmp==1);
if theta~=0
    %line is not perpendicular to the x axis
    lineX=[min(indx),max(indx)];
    lineY=(rho-x*cos(theta))/sin(theta);
else
    lineX=[rho, rho];
    lineY=[1, row];
end

figure(1);
h1=plot(indx,indy,'o');
h2=ploe(lineX,lineY,'-.');
legend([h1,h2],'Data Points','Best Fit Line');
