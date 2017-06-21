function [x, dx, ddx, dddx] = derivatives(x,t)

    dx = [diff(x/t);nan];
    ddx = [diff(dx/t);nan];
    dddx = [diff(ddx/t);nan];

end