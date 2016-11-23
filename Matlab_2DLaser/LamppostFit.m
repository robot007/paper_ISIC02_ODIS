function [org, r]=LamppostFit(dat,row,col,varargin)
% [org, r]=CircleFit3D(dat,row,col)
% Fit cylander lamppost 
% ORG : Origin
% R : Radius
% DAT : input 
% ROW, COL : size of the inputs 
%
% Need function: ToImg, 
%
% Zhen Song zhensong@cc.usu.edu
%

    DatImg=ToImg(dat, row, col);
    DatEdge=edge(DatImg,'canny');
    [IndRow, IndCol]=find(DatEdge);
    len=length(IndRow);
    IndFinal=[IndRow(1)*col+IndCol(1)];
    % initialize IndFinal, the index of the points 
    % will be fit as a circle 
    IndAfterEdgeDet=IndRow*col+IndCol;
    % IndAfterEdgeDet is the index of left points 
    % after edge detection. This basically revert
    % 2D image back to 3D data set. 
    
    %delete the ``walls''
    AdjucentThreshold=0.01;
    % If adjucent points are closer then this threshold
    % then they are actually one point.
    for cnt=2:len
        Ind=IndRow(cnt)*col+IndCol(cnt);
        len2=length(IndFinal);
        if isempty( find( abs(dat(IndFinal,1)-dat(Ind,1)*ones(len2,1))+...
                abs(dat(IndFinal,2)-dat(Ind,2)*ones(len2,1))...
                <ones(len2,1)*AdjucentThreshold )  )==1
            IndFinal=[IndFinal; Ind];
        end
    end
            
    X=dat(IndFinal,1:2);
    B  = [ X(:,1).^2+X(:,2).^2  X(:,1)  X(:,2) ones(size(X(:,1)))];
    [U S V]= svd(B);
    u = V(:,4); a = u(1); b =[u(2); u(3)]; c = u(4);
    z = -b/2/a; r = sqrt(norm(z)^2 - c/a);
    org=z;
    
    if ~isempty(varargin{:})
        %visulize all the data set
        figure(1);
        plot3(dat(:,1),dat(:,2),dat(:,3),'*');
        xlabel('x');
        ylabel('y');        
        zlabel('z'); 
        title('Input Raw Data for Circular Lamppost Fit');
        print -depsc2 img/CirLamppost.eps
        print -djpeg  img/CirLamppost.jpg
        print -dpng   img/CirLamppost.png          
        
        figure(2);
        imshow(DatImg);
        title('Map 3D Data to 2D Image');
        print -depsc2 img/CirLamppostMap2D.eps
        print -djpeg  img/CirLamppostMap2D.jpg
        print -dpng   img/CirLamppostMap2D.png   
        
        figure(3);
        imshow(DatEdge);
        title('Detect Edge');
        print -depsc2 img/CirLamppostDetectEdge.eps
        print -djpeg  img/CirLamppostDetectEdge.jpg
        print -dpng   img/CirLamppostDetectEdge.png    
        
        figure(4);
        plot3(dat(IndAfterEdgeDet,1),dat(IndAfterEdgeDet,2),...
            dat(IndAfterEdgeDet,3),'*');
        xlabel('x');
        ylabel('y');        
        zlabel('z'); 
        title('After Edge Detection');
        print -depsc2 img/CirLamppostAfterEdgeDetection.eps
        print -djpeg  img/CirLamppostAfterEdgeDetection.jpg
        print -dpng   img/CirLamppostAfterEdgeDetection.png        
        
        figure(5);
        plot3(dat(IndFinal,1),dat(IndFinal,2),dat(IndFinal,3),'*');
        xlabel('x');
        ylabel('y');        
        zlabel('z');         
        title('Ready for Fitting');
        axis equal;axis([1.2 2.5 -1 1 0 0.3]);
        print -depsc2 img/CirLamppostReadyForFitting.eps
        print -djpeg  img/CirLamppostReadyForFitting.jpg
        print -dpng   img/CirLamppostReadyForFitting.png
        
        
        figure(6);
        plot(dat(IndFinal,1),dat(IndFinal,2),'*');
        hold on;
        axis equal;
        drawcircle(org,r)
        xlabel('x');
        ylabel('y');  
        title('Fit the Circular Lamppost');
        print -depsc2 img/CirLamppostFit.eps
        print -djpeg  img/CirLamppostFit.jpg
        print -dpng   img/CirLamppostFit.png
    end
return
    
