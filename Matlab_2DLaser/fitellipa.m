   % x & y must be column vectors.
   % x,y are lists of coordinates.
function a = fitellipa(X,Y)

   D = [ X.*X  X.*Y  Y.*Y  X  Y  ones(size(X)) ];
   [U S V] = svd(D);
   a   = V(:,6)

