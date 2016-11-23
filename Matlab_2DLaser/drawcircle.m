function drawcircle (z, r, pat, OPTIONS);
%DRAWCIRCLE	Draw circle
%
%	drawcircle (z, r, pat{'-'}, OPTIONS{[]})
%	draws a circle into the current figure.
%
%	z, r: center and radius of circle
%	pat: pattern to be used (e.g. '--' for dashed)

  if (nargin < 4), OPTIONS = [2]; end;
  if (nargin < 3), pat = '-'; end;

  theta = [0:0.02:2*pi];  
  u = z(1) + r*cos(theta);  
  v = z(2) + r*sin(theta);
  plot(u, v, pat);
  if (isempty(OPTIONS==2)),
    plot(z(1),z(2),'+');
  end

  %end % drawcircle
