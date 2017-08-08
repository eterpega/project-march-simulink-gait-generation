function [f, plotPhase] = rearrange_from_zero_to_hundered(f, plotPhase)
%First we make sure now phase >= 100%. This will make sure that from 100%
%the phase is set back to zero and increaces until the phase of the first
%key event.
plotPhase = mod(plotPhase,100);

%Than we sort the phase to make sure it is trictly increasing, we also save
%the sort index for later use. This will pick up the phase after 100% at
%put it at front
[plotPhase, sortIndex] = sort(plotPhase);

%The sort index is used to sort f in the same matter as the phase has been
%sorted. This will pick up the f values after 100% pahse and move it to the
%front
f = f(sortIndex);
end