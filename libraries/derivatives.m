function [x, dx, ddx, dddx] = derivatives(x,tInterval)

%Here an approximation of the first, second, and third derivative is
%calculated.
dx = [diff(x)/tInterval;nan]; %[.../s]
ddx = [diff(dx)/tInterval;nan]; %[.../s^2]
dddx = [diff(ddx)/tInterval;nan]; %[.../s^3]
end