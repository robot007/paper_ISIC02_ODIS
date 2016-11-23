%This is a simple program to generate simulation 2D laser points cloud
%Left click your mouse: input a new point
%Right click your mouse: finish input processdure,and store information in "simupt.dat"
%
% Zhen Song zhensong@cc.usu.edu
disp('Left click your mouse: input a new point');
disp('Right click your mouse: finish input processdure,and store information in "simupt.dat"');
disp('When you type "load simupt", you will load the data set to a n by 2 matrix "pt"');
gx=[];
gy=[];
axis([0.6 2 -1 1]);
axis square;
hold on;
grid on;
xlabel('y');
ylabel('x');
but=1;
while but==1;
    [y, x, but]=ginput(1);
    if but==1
        plot(y,x,'*');
        gx=[gx; x];
        gy=[gy; y];
    end
end
pt=[gx, gy];
save simupt pt;
    