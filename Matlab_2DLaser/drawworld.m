%
%
%
% 
world=zeros(4,3,7);
sq2=sqrt(2);
hi=0.2;
el=1; %element length
dis=1; %distance to origin
world(:,:,1)=[dis 0 0; dis+el -el 0; dis+2*el 0 0; dis+el el 0]; % bottom
world(:,:,2)=[dis 0 hi; dis+el -el hi; dis+2*el 0 hi; dis+el  el hi]; % upper
world(:,:,3)=[dis,0,0; dis+el,-el,0; dis+el,-el,hi;  dis,0,hi]; %front right
world(:,:,4)=[dis,0,0; dis,0,hi; dis+el,el,hi; dis+el,el,0]; %front left
world(:,:,5)=[dis+el,-el,0; dis+2*el,0,0; dis+2*el,0,hi; dis+el,-el,hi]; %behind right
world(:,:,6)=[dis+2*el,0,0;  dis+el,el,0;  dis+el,el,hi;  dis+2*el,0,hi];  %behind left
world(:,:,7)=[4,-2,0;  4,2,0;  -2,2,0;  -2,-2,0]; %ground 

h=1.5;
MyCamera=[0 0 h];
figure;
title('Object');    
plot3(MyCamera(1),MyCamera(2),MyCamera(3),'or');
hold on;
grid on;
view(3);
axis([-3 3 -3 3 -1 5]);
handle=[];
for cnt1=1:6
    xx=[world(:,1,cnt1); world(1,1,cnt1)]';
    yy=[world(:,2,cnt1); world(1,2,cnt1)]';
    zz=[world(:,3,cnt1); world(1,3,cnt1)]';
    p1=patch('XData',xx,'YData',yy,'ZData',zz,'FaceColor','blue');
    handle=[handle; p1];
end

 xx=[world(:,1,7); world(1,1,7)]';
 yy=[world(:,2,7); world(1,2,7)]';
 zz=[world(:,3,7); world(1,3,7)]';
 p1=patch('XData',xx,'YData',yy,'ZData',zz,'FaceColor','yellow');
 handle=[handle; p1];
 
%  for cnt1=1:length(handle)
%      set(handle(cnt1), 'FaceColor','interp');
%  end
%  colormap(hot(10));