p1=[2.85310,-3.68630];
p2=[2.87320, -3.64520];
plot(p1(1),p1(2),'o');
hold on; 
plot(p2(1),p2(2),'o');

Pi=3.14159265358979;
DEG2RAD=180/Pi;
ThetaAtom= 18*DEG2RAD;
RhoAtom= 0.5;
RhoMin= 0.5;

% [found, corner]=cornerdet(dat,col,method)
 [found, corner]=cornerdet(dat(:,1:3),81,11)

 figure
 plot3(corner(:,1),corner(:,2),corner(:,3),'or');
 hold on; 
 plot3(dat(:,1),dat(:,2),dat(:,3),'ob');
 
 plot3(PtOne(:,1),PtOne(:,2),PtOne(:,3),'o');
 plot3(PtWall(:,1),PtWall(:,2),PtWall(:,3),'o');