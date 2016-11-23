%function drawhough
p0=[1 1];
p1=[0.4,1.3];
x=[-2, 2];
y=-0.5.*x+1.5;
%y1=2*x1, intersection: (0.6,1.2)
x1=[0, 0.6];
y1=2*x1;

%perdendicular sign
d=0.2;
tg1=2;
ang=atan(tg1);
cos1=cos(ang);
intersecPt=[0.6, 1.2];
px1=[intersecPt(1)-d*cos1, intersecPt(1)];
py1=-0.5*px1+1.5-d/sin(ang);
px2=[intersecPt(1), intersecPt(1)+d*cos1];
py2=2*px1-d/sin(ang);

figure(1);
line(x,y);
axis equal;
hold on;
plot(p0(1),p0(2),'o');
plot(p1(1),p1(2),'o');
text(p1(1),p1(2)-0.5,'Point B');
text(p0(1),p0(2)-0.5,'Point A');
plot(0,0,'o');
text(0,0.2,'O');
text(0.1,0.1,'{\theta}');
text(0.2,0.3,'{\rho}');
line(x1,y1);
text(0.05,2,'y');
text(1.5,-0.1,'x');
title('Hough Transform: Euclidean Space')
print -depsc houghtrans1.eps
unix('!epstopdf houghtrans1.eps');
%line(px1,py1);
%line(px2,py2);

figure(2);
theta=-pi:0.1:pi;
dist=cos(theta)+sin(theta);

title('Hough Transform: Accumulation Space')
rho=0.6/cos(ang);
plot(ang, rho,'o');
hold on;
plot(theta,dist,'-.');

dist2=cos(theta)*p1(1)+sin(theta)*p1(2);
plot(theta,dist2,'-.r');

axis([-pi,pi, -2,2]); axis equal;
text(1,1.5,'Line L1');
text(0, 1.4,'Point A');
text(-0.2, 0,'Point B');
text(-2,-1.5,'Fake Line L1, whose {\rho}<0');
xlabel('{\theta}');
ylabel('{\rho}');
print -depsc houghtrans2.eps
unix('!epstopdf houghtrans2.eps');

% function arrow(pstart, pend,hight)
% line([pstart(1),pend(1)],[pstart(2),pend(2)]);
% if pstart(1)~=pend(1)
    

%sparse hough
p1=[1,1];
p2=[2,2];
p3=[1.5,0.5];
figure(1)
hold on; axis equal;
title('Sparse Hough: Elucidean Space');
axis([0 2.5 0 2.5]);
plot(p1(1),p1(2),'o');
plot(p2(1),p2(2),'o');
plot(p3(1),p3(2),'o');
line([p1(1), p2(1)], [p1(2),p2(2)]);
line([p1(1), p3(1)], [p1(2),p3(2)]);
line([p2(1), p3(1)], [p2(2),p3(2)]);

text(p1(1),p1(2),'A');
text(p2(1),p2(2),'B');
text(p3(1),p3(2),'C');
print -depsc2 sphough1.eps
print -djpeg90 sphough1.jpg
unix('!epstopdf sphough1.eps');

figure(2);
title('Sparse Hough: Accumulation Space');
hold on; axis equal;
axis([-pi pi -0.1 2]);

k=(p1(2)-p2(2))/(p1(1)-p2(1));
theta1=atan(k+pi/2);
rho1=p1(1)*cos(theta1)+p1(2)*sin(theta1);

A2=[p1; p3];
Ks=inv(A2)*[1; 1];
k=-Ks(1)/Ks(2);
d=1/Ks(2);
theta2=atan(k+pi/2);
rho2=p1(1)*cos(theta2)+p1(2)*sin(theta2);

A3=[p2; p3];
Ks=inv(A3)*[1; 1];
k=-Ks(1)/Ks(2);
d=1/Ks(2);
theta3=atan(k+pi/2);
rho3=p2(1)*cos(theta3)+p2(2)*sin(theta3);

h1=plot(theta1,rho1,'o');
text(theta1,rho1,'A-B');
h2=plot(theta2,rho2,'or');
text(theta2,rho2,'A-C');
h3=plot(theta3,rho3,'ob');
text(theta3,rho3,'B-C');
axis([-pi,pi, -2,2]); axis equal;
xlabel('{\theta}');
ylabel('{\rho}');
print -depsc2 sphough2.eps
unix('!epstopdf sphough2.eps');
%log-hough
