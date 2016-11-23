disp('ISIC Demo: Demo for ISIC paper 2002');
disp('Some Sensing and Perception Techniques for  an Omnidirectional Ground Vehicle With a Laser Scanner');
disp('Authors:Zhen Song,   YangQuan Chen,  Lili Ma and   You Chung Chung');
disp('1. Algebric circle fitting with unknown radius');
    a = [
    1.1161    0.1735
    1.0357    0.1528
    1.0357    0.1528
    1.0105    0.1464
    1.0105    0.1464
    0.9972    0.1050
    0.9972    0.1050
    0.9854    0.1025
    0.9854    0.1025
    0.9854    0.1025
    0.9883    0.0661
    0.9883    0.0661
    0.9745    0.0636
    0.9745    0.0636
    0.9705    0.0629
    0.9719    0.0243
    0.9700    0.0240
    0.9700    0.0240
    0.9700    0.0240
    0.9700    0.0240
    0.9710   -0.0109
    0.9710   -0.0109
    0.9710   -0.0109
    0.9710   -0.0109
    0.9710   -0.0109
    0.9756   -0.0455
    0.9756   -0.0455
    0.9816   -0.0451
    0.9816   -0.0451
    0.9896   -0.0446
    0.9872   -0.0797
    0.9982   -0.0794
    0.9982   -0.0794
    0.9982   -0.0794
    0.9982   -0.0794
    0.9946   -0.1144
    1.0286   -0.1145
    1.0286   -0.1145
    1.0456   -0.1145
    1.0456   -0.1145
    1.1797   -0.1572
 ];
figure;
plot(a(:,2),a(:,1),'or');hold on; grid on;axis equal;
disp('This is the raw data points');
pause;

hold on
xin=[a(:,2),a(:,1)];
[z, r] = algcircle(xin);
drawcircle (z, r, '-m', '+m')
disp('This is algbric circle fitting');
pause;

disp('Diameter is 0.3345m');
rstar=.3345/2;  % I assume that radius is known! Let's do a fitting
[z] = krcircle(xin,z,rstar);
drawcircle (z, rstar, '-k', 'xk');
legend('laser scanned rubbish bin (d =33.45 cm)',['fitted (d=',num2str(r*200),' cm)'],'estimated center',...
    'geo fit with known radius','estimate center with fixed radius')
axis equal;
disp('This is the known radius circle fitting');
pause;

figure(2);
disp('Ellipse fitting');
X=[-0.08600004206036 
    -0.07794299456979  
   2.43242519802460   
   2.09758733070173   
   3.13534679991087   
   3.56316973735175   
   3.86544589720640   
   3.61927294746144   
   3.95584762348697   
   4.53062506445827   
   4.19990452535833   
   4.35659188802714   
   5.87362160279331  
   4.94488255274615  
   4.02489210925304 
   4.49939898211824 
   3.54463330891794 
   3.04299968801745 
   3.26607455580647 
   3.51100552876526 
   2.48595502853656 
   2.23450327175463 
   0.54275781698829 
   0.35030306011783 
  -0.15746397170300 
  -1.35455740891787 
  -2.03511163469000 
  -1.28189225442613 
  -2.40202143267810 
  -3.32601375087707 
  -2.93929825377602 
  -3.71359060741068 
  -4.81549543051928 
  -3.72038384196387 
  -4.58158136075272 
  -4.02408601903468 
  -4.30731683442634 
  -5.40061679322316 
  -5.68659788062301 
  -4.79903834723396 
  -4.72249459026576 
  -4.72781621100295 
  -3.55390441536928 
  -2.52964124710135  
  -3.26681179832294  
  -2.91682326883842   
  -1.98842468027433   
  -0.84563494831073  
  -1.13918459250291  
  -0.72078888920343  ];
Y=[  9.84922535631035
    9.64665520238136
    9.58894219243244
     8.40577225886695
   8.00036929745479
   7.02883511552260
   6.32664176367285
   6.27935930946325
  3.89390320008437
   2.28175233943933
    2.15544301777705
   0.08576502972247
    -0.60637741205545
   -2.25033187783735
    -2.76893117120001
   -3.92606280519643
   -5.48048223753038
    -7.60683470582086
   -7.21014983536375
    -7.13440552148986
   -8.15201972726381
   -10.24600635846441
    -9.73302876290198
   -10.33014112914620
   -10.61473183445742
  -10.66175909993534
  -9.51254740004811
   -9.55534666161366
   -8.72958608633275
   -8.31089408379386
  -7.56867029451679
  -6.15166354717752
  -4.92129819085907
   -2.99049681378782
  -3.90454858960753
  -2.48737923245777
   -0.00520467606188
   0.39402546620703
   1.04505377144534
   3.27949552341289
    5.18973845675993
  5.78300428056945
   7.54867075057540
    7.59241168636941
   9.20888735604066
   8.55917973398965
    8.61389721749457
    9.55915752125815
  10.63529397489550
   9.33027474532863];
XX=X; YY=Y; % if select half of the data points, the fitting will be very unprecise.
plot(XX,YY,'or');
hold on; grid on; axis equal;
parameter=fitellipa(XX,YY);
ans=solveellipse(parameter);
% returning [r1 r2 cx cy theta]
drawellipse([ans(3),ans(4)],ans(1),ans(2),ans(5));
legend('raw data of an ellipse', 'fitted ellipse');
pause;



%compare memory, speed, and resolution of SHT, SPHT, LHT
disp('2. Compare SHT, SPHT and logHT (LHT)');
disp('Distance 50cm to 10m, resolution 1cm/0.5 degree. Scan 0 to 360 degree');
dist=[50:200];
AngRes=0.5;
len=length(dist);

subplot(3,1,1);
Points=[1:720];
Degree=Points./2;
SHTmem=Points.*(360/AngRes); %
SPHTmem=Points.*(Points-1)/2*3; %
LHTmem=338*Points;
h1=plot(Degree,SHTmem);
hold on;
h2=plot(Degree,SPHTmem,':');
h3=plot(Degree,LHTmem,'-.');
xlabel('Scanning Angle(degree)');
ylabel('Memory Required');
legend([h1,h2,h3],'SHT','SPHT','LHT');
title('Memory Requirement Comparision');

len=length(Points);
SHTcomp=Points*(360/AngRes);
SPHTcomp=Points.*(Points-1)/2;
LHTcomp=Points;
axis([0, max(dist),0,1.5e5]); 
subplot(3,1,2);
hold on;
h1=plot(Degree,SHTcomp);
h2=plot(Degree,SPHTcomp,':');
h3=plot(Degree,LHTcomp,'-.');
xlabel('Scanning Angle(degree)');
ylabel('Computation Complexity');
legend([h1,h2,h3],'SHT', 'SPHT','LHT');
title('Complexity Comparison ');

subplot(3,1,3);
hold on;
dist=[100:0.1:1000];
r1=1000;
r0=50;
len=length(dist);
HTres=0.1*ones(1,len);
N=ceil(log((max(dist)-r0)/50)./(AngRes*pi/180));%how many point to provide the resolution
n=ceil( log((dist-r0)/r0)./  (log((r1-r0)/r0)/(N-1))    ) ; %log(max((dist)-min(dist))/N) is one segment in log space
LHTres=exp((n+1)*AngRes*pi/180)-exp(n*AngRes*pi/180);
LHTres=LHTres*100; %m -> cm
h2=plot(dist,HTres);
h1=plot(dist,LHTres,'-.');
legend([h1,h2],'LHT','SHT SPHT');
xlabel('Distance(cm)');
ylabel('Resolution(cm)');
axis([0 1000, -1,20]);
title('Resolution Comparision');


% corner fitting by planes : cfit
% corner fitting by logarithm : 
% check if a vector is perpendicular to a known plane : perpen
% 
disp('3.Sparse Hough Transform');
disp('Read data from "DataForSPHT.mat". ');
disp('You can use "GetPt.m" to gemerate your own simulation data. ');
clear all;
load DataForSPHT;
spht(pt,0.35,[2,2],'cal');


disp('4.Lamp Pole Simulation');
disp('This will take several minutes. Press any and wait a while, please.');
pause;
disp('Computing....');
simulaserpole; %store data to 'dat.dat'
clear all;
load dat; 
disp('Ok');

disp('Simulation For a Lamp Pole');
figure;
plot3(dat(:,1),dat(:,2),dat(:,3),'o');
title('Simulation For a Lamp Pole');

figure;
img=toimg(dat,68,81); % from 3D data to 2D image
TheMax=max(max(img));
TheMin=min(min(img));
% img=(img-TheMin)/(TheMax-TheMin)*255; %scale to 0~255
% image(img);  % color image
img=(img-TheMin)/(TheMax-TheMin); %scale to 0~1
imshow(img);
title('Projection Of 3D Lamp Pole Data');
disp('This is the projection of the 3D data. Press any key to go on.');


pause ;
figure;
bw=edge(img,'sobel'); %edge detection
imshow(bw);
title('The Result of The Edge Detection');
disp('This is the result of the edge detection. Press any key to go on');

pause;

figure;
[row,col]=size(bw);
MinDis=[1000 0 0];mid=[68 40];
[IndRow, IndCol]=find(bw);
len=length(IndRow);
for cnt=1:len
    if sqrt( (IndRow(cnt)-mid(1))^2+(IndCol(cnt)-mid(2))^2 )<MinDis(1)
        MinDis=[norm([IndRow(cnt), IndCol(cnt)]), IndRow(cnt), IndCol(cnt)];
    end
end
bw(MinDis(2), MinDis(3))=0;
imshow(bw);   
disp('Elliminate Useless Data');


[org,r]=LamppostFit(dat,68,81,'draw');
disp('Done');

disp('Segement and fit circle');
SegFitCirLine;

