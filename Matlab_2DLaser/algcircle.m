function [z, r] = algcircle (X);
%ALGCIRCLE      Algebraic circle fit
%
% [z, r] = algcircle (X);
% fits a circle by minimizing the "algebraic distance"
% in the least squares sense  a x'x + b'x + c = 0
%
% X : given points <X(i,1), X(i,2)>
%
% z, r: center and radius of the found circle
   
  B  = [ X(:,1).^2+X(:,2).^2  X(:,1)  X(:,2) ones(size(X(:,1)))];
  [U S V]= svd(B);
  u = V(:,4); a = u(1); b =[u(2); u(3)]; c = u(4);
  z = -b/2/a; r = sqrt(norm(z)^2 - c/a);

  %end of algcircle
