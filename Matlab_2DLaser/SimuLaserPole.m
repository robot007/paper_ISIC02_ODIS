function SimuLaserPole
world=zeros(4,3,7);
sq2=sqrt(2);
hi=0.2;
el=1; %element length
dis=1; %distance to origin
x0=1;
y0=0;
r0=0.1;
world(:,:,7)=[-1e6,-1e6,0;  1e6,-1e6,0;  1e6,1e6,0;  -1e6,1e6,0]; %ground 


h=1.5; %the height of laser
MyCamera=[0 0 h];

planes=zeros(7,4); %plane parameters of the world
planes(1,:)=[det([world(1:3,2,7), world(1:3,3,7), ones(3,1)]), ...
        -det([world(1:3,1,7), world(1:3,3,7), ones(3,1)]), ...
         det([world(1:3,1,7), world(1:3,2,7), ones(3,1)]), ...
        -det([world(1:3,1,7), world(1:3,2,7), world(1:3,3,7)])   ]; %find parameters of planes

dat=[]; %laser data
d2r=pi/180; %degree to rad
for alpha=5*d2r:1*d2r:72*d2r  %row 68
    line=[]; %one line of laser
    for beta=-40*d2r:1*d2r:40*d2r %col 81
        cb=cos(beta);
        sb=sin(beta);
        ca=cos(alpha);
        sa=sin(alpha);
        tmin=10;
        %t of ground
        tg=-dot(planes(1,:), [0, 0, h, 1])/(dot(planes(1,:) , [cb*sa, sb, -ca*cb, 0] ) ); %intersection point
        
        %intersection with the pole
        %t^2*sa^2+t(-2*sa*cb*x0-2*sa*sb*y0)+x0^2+y0^2-r0=0
        a=sa^2;
        b=-2*sa*cb*x0-2*sa*sb*y0;
        c=x0^2+y0^2-r0;
        if b^2-4*a*c >=0
            tc=(-b-sqrt(b^2-4*a*c))/(2*a);
        else 
            tc=inf;
        end

        if tg<tc
            IntPt = [cb*sa, sb , -ca*cb].*tg +[0, 0, h];
        else
            IntPt = [sa*cb, sa*sb, -ca].*tc +[0, 0, h];
        end
        
        
        dat=[dat; IntPt, alpha, beta]; %dat: [x,y,z,alpha,beta; x, y,...]
    end %beta
end %alpha
save dat;