%segment a line and a circle by Hough transform
%then fit the circle

%Cirle and a line 
Cline =[
    0.7045,    1.2933
    0.6725,    1.2888
    0.6502,    1.2955
    0.6118,    1.2911
    0.5735,    1.2911
    0.5543,    1.2933
    0.5256,    1.2933
    0.4936,    1.2888
    0.4712,    1.2911
    0.4393,    1.2911
    0.4233,    1.2888
    0.3946,    1.2911
    0.3594,    1.2911
    0.3275,    1.2866
    0.3051,    1.2955
    0.2700,    1.2955
    0.1735,    1.1161
    0.1528,    1.0357
    0.1528,    1.0357
    0.1464,    1.0105
    0.1464,    1.0105
    0.1050,    0.9972
    0.1050,    0.9972
    0.1025,    0.9854
    0.1025,    0.9854
    0.1025,    0.9854
    0.0661,    0.9883
    0.0661,    0.9883
    0.0636,    0.9745
    0.0636,    0.9745
    0.0629,    0.9705
    0.0243,    0.9719
    0.0240,    0.9700
    0.0240,    0.9700
    0.0240,    0.9700
    0.0240,    0.9700
   -0.0109,    0.9710
   -0.0109,    0.9710
   -0.0109,    0.9710
   -0.0109,    0.9710
   -0.0109,    0.9710
   -0.0455,    0.9756
   -0.0455,    0.9756
   -0.0451,    0.9816
   -0.0451,    0.9816
   -0.0446,    0.9896
   -0.0797,    0.9872
   -0.0794,    0.9982
   -0.0794,    0.9982
   -0.0794,    0.9982
   -0.0794,    0.9982
   -0.1144,    0.9946
   -0.1145,    1.0286
   -0.1145,    1.0286
   -0.1145,    1.0456
   -0.1145,    1.0456
   -0.1572,    1.1797
   -0.2252,    1.2933
   -0.2476,    1.2911
   -0.2796,    1.2978
   -0.3115,    1.2978
   -0.3243,    1.2933
   -0.3403,    1.2888
   -0.3658,    1.2888
   -0.4010,    1.2911
   -0.4329,    1.2911
   -0.4649,    1.2911
   -0.4968,    1.2911
   -0.5351,    1.2955
   -0.5607,    1.2955
   -0.5799,    1.2888
   -0.6118,    1.2888
   -0.6502,    1.2843
   -0.6629,    1.2955
   -0.6949,    1.2955
   -0.7173,    1.2933
   -0.7588,    1.2933
   -0.7812,    1.2955
   -0.8035,    1.2955];
%save CirLineRaw Cline 

%% You can also load X from .mat file 
clear all
load CirLineRaw
 figure(1);
 plot(Cline(:,1),Cline(:,2),'o');
 title('Raw Laser Data');
 axis equal; grid on;

 [Ang,Rho]=spht(Cline,-1, [1, 1],'cal');
% print -deps2c SPHTSegCirLine.eps
% print -djpeg SPHTSegCirLine.jpg
% print -dpng SPHTSegCirLine.png

% Segment 
LineSegThreshold=0.05; %5 cm 
% if a point is within 1cm distance to the 
% best fit line, then we believe it is on
% the line 
CirSegThreshold=0.05; %5cm
% if the distance of adjucent two points on the
% circle is greater than CirSegThreshold, then 
% delete the former one, if it is the first half part
% or delete the later one, if it is the second half 
% part. This will eliminate the wild points. 
AllRho=Cline(:,1).*cos(Ang)+Cline(:,2).*sin(Ang);
ErrRho=abs(AllRho-Rho);
LinePtInd=find(ErrRho<LineSegThreshold);
LinePt=Cline(LinePtInd,:);
OtherPtInd=find(ErrRho>LineSegThreshold);
OtherPt=Cline(OtherPtInd,:);
len=size(OtherPt,1);
midpt=round(len/2);
CirPt=[];
WildPt=[];
for cnt=2:len
    if norm(OtherPt(cnt-1,:)-OtherPt(cnt,:))>CirSegThreshold
        %if the distance between adjacent points are too large
        if cnt<midpt
            %we are in the 
            CirPt=[]; 
            %start again;
            disp('Found wild point at the first part');
            WildPt=[WildPt; OtherPt(cnt,:)];
        else
            disp('Found wild point at the second part');
            WildPt=[WildPt; OtherPt(cnt:len,:)];
            %stop the for loop
            break;            
        end
    else
        % if the points are near to each other
        CirPt=[CirPt; OtherPt(cnt,:)];
    end
end

figure(3);
h1=plot(CirPt(:,1),CirPt(:,2),'o');
hold on;axis equal; grid on;
[z, r] = algcircle(CirPt);
drawcircle (z, r, '-m', '+m')
title('Fitted Circle after Segmentation');
h2=plot(WildPt(:,1),WildPt(:,2),'*r');
h3=plot(LinePt(:,1),LinePt(:,2),'>b');
h4=plot(z(1),z(2),'+');
legend([h1,h2,h3,h4],'Points on Circle','Wild Points',...
    'Points on Line','Center of the Circle');
% 
% print -deps2c HoughSegCirFit.eps
% print -dpng HoughSegCirFit.png
% print -djpeg HoughSegCirFit.jpg
