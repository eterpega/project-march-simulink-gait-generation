function [y, dydx, d2ydx2, d3ydx3] = phase_to_time(y, dydx, d2ydx2, d3ydx3)
%Defivatives are genrated for %, we want to convert this into time
%100% stride = 2 steps
%if step frequency is 1 this means 100 [%] stride is 2 [s]
converter = 100/4; %[%/s]

y      = y;
dydx   = converter * dydx;
d2ydx2 = converter^2 * d2ydx2;
d3ydx3 = converter^3 * d3ydx3;
end