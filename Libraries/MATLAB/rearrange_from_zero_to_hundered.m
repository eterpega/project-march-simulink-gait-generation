function [f, d, s, t, plotPhase] = rearrange_from_zero_to_hundered(f, d, s, t, plotPhase)

plotPhase = mod(plotPhase,100);

[plotPhase, sortIndex] = sort(plotPhase);
f = f(sortIndex);
d = d(sortIndex);
s = s(sortIndex);
t = t(sortIndex);
end