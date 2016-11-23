function drawellipse (z, a, b, alpha, pat, OPTIONS)
%DRAWELLIPSE	Draw ellipse
%
%	drawellipse (z, a, b, alpha, pat{'-'}, OPTIONS{[]})
%	draws ellipse into current figure.
%
%	z, a, b, alpha: parameters of ellipse
%	pat: pattern to be used

  if (nargin < 6), OPTIONS = [2]; end;
  if (nargin < 5), pat = '-'; end;

  s = sin(alpha); c = cos(alpha);
  Q =[c -s; s c];
  theta = [0:0.02:2*pi];
  u = diag(z)*ones(2,length(theta)) + ...
      Q*[a*cos(theta); b*sin(theta)];
  plot(u(1,:),u(2,:), pat);
  if (find(OPTIONS==2) == []),
    plot(z(1),z(2),'+');
  end
  if (find(OPTIONS==1) ~= []),
    if (a < b), 
      alpha = alpha + pi/2;
      tmp = a; a = b; b = tmp;
    end
    alpha = alpha - pi*floor(alpha/pi);
    at = text(z(1),z(2),'  a');
    at2 = text(z(1)+1,z(2),'  a');
    set(at2,'Visible','off');
    ext = get(at, 'Extent');
    xa2  = ext(1);
    set(at, 'FontName', 'Symbol');
    ext = get(at, 'Extent');
    wa  = ext(3);
    xa  = ext(1);
    bt  = text(z(1)+(xa2-xa)/wa,z(2),sprintf(' = %1.4f',alpha));
  end 

end % drawellipse

