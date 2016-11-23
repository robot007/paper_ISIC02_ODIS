%
% Given an ellipse in the form:
%       a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0
% finds the standard form:
%       ((x-cx)/r1)^2 + ((y-cy)/r2)^2 = 1
% returning [r1 r2 cx cy theta]
%
function v = solveellipse1(a)
% s:=sin(\theta), c:=cos(\theta)
% let [x y]'=\left[\begin{matrix}
%   c & -s \cr
%   s & c \cr \end{matrix}\right]
% [x' y']'
%       a(1)x^2 + a(2)xy + a(3)y^2 + a(4)x + a(5)y + a(6) = 0
% ((x'-cx)/r_1)^2 + ((y'-cy)^2/r_2)^2 = 1
%
% (r_1^2 s^2+r_2^2 c^2) x'^2 + (r_2^2 s^2+r_1^2 c^2)y'^2 +(-2b^2 cx c-2a^2 cy s) x'
%   + (2r_1^2 cy s-2r_2^2 cy c) y' +(-2r_2^2 sc + 2r_1^2 sc)x'y' +cx^2 b^2 + a^2 cy^2 -a^2 b^2=0
% so, a(1)-a(3)=r_1^2(s^2-c^2)+r_2^2(c^2-s^2)=(r_1^2-r_2^2)(s^2-c^2)
% a(2)=-2r_2^2 sc + 2r_1^2 sc=(2sc)(r_1^2-r_2^2)
% thus a(2)/( a(1)-a(3) )=tan(2\theta)
        % get ellipse orientation
        theta = atan2(a(2),a(1)-a(3))/2;

        % get scaled major/minor axes
        ct = cos(theta);
        st = sin(theta);
        ap = a(1)*ct*ct + a(2)*ct*st + a(3)*st*st;
        cp = a(1)*st*st - a(2)*ct*st + a(3)*ct*ct;

        % get translations
        T = [[a(1) a(2)/2]' [a(2)/2 a(3)]'];
        t = -inv(2*T)*[a(4) a(5)]';
        cx = t(1);
        cy = t(2);

        % get scale factor
        val = t'*T*t;
        scale = 1 / (val- a(6))

        r1 = 1/sqrt(scale*ap);
        r2 = 1/sqrt(scale*cp);
        v = [r1 r2 cx cy theta]';

        
