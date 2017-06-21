function [f, plotPhase] = rearrange_from_zero_to_hundered(f, plotPhase)

plotPhase = mod(plotPhase,100);

[plotPhase, sortIndex] = sort(plotPhase);
f = f(sortIndex);
end