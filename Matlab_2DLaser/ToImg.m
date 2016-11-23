function img=ToImg(dat, row ,col)
% dat=data;
% row=20;
% col=361;
%row=41;
%col=61;
%dat in the format (x,y,z)
img=zeros(row,col,1);
pt=1;
TheMax=max(dat(:,3))
TheMin=min(dat(:,3))

for cnt1=1:row
    for cnt2=1:col
        img(cnt1,cnt2)=(dat(pt,3)-TheMin)*(1/(TheMax-TheMin));
        pt=pt+1;
    end
end
TheMax
TheMin

return;
