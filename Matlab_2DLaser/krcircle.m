function [z] = krcircle(X, z, rstar);
%CIRCLE         Geometric circle fit with a known radius
%
% [z,r] = circle (X, z, r)
% fits the best circle by nonlinear least squares
% for true geometric distance.
%
% X: given points <X(i,1), X(i,2)>
% z: starting values for cicle solution
%
% z: parameters for ellipse found

r=rstar;   % rstar is the known radius
u = [z(1), z(2) ]'    % Starting values
  h = u;
  it=0;
  while norm(h)>norm(u)*1e-6,
    a = u(1)-X(:,1); b = u(2)-X(:,2);
    fak = sqrt(a.*a + b.*b);
    J = [a./fak b./fak ];  
    f = fak - rstar;
    h = -J\f;
    u = u + h;
    it=it+1;
  end;
  z = u(1:2);
it
