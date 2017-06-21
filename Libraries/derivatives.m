function [x, dx, ddx, dddx] = derivatives(x,t)

%Here an approximation of the first, second, and third derivative is
%calculated.
dx = [diff(x/t);nan];
ddx = [diff(dx/t);nan];
dddx = [diff(ddx/t);nan];
end