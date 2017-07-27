function [xRightOut, xLeftOut] = lock_x_stance_leg(xRightIn, ...
    xLeftIn, stanceLegRight, stanceLegLeft, dynamic)

xFootRight = xRightIn(1,:);
xFootLeft = xLeftIn(1,:);
samplePointAmount = length(xFootLeft);
xDiff = xFootRight .* stanceLegRight' + xFootLeft .* stanceLegLeft';

iOverStep = diff(stanceLegLeft);
iOverStep = [1 , find(iOverStep)'];
lengthOverStep = xFootLeft(iOverStep(2:end)) - xFootLeft(iOverStep(1:end-1));

xDiffOverStep = zeros(1,samplePointAmount);

for i = 1:(length(iOverStep)-1)
    xDiffOverStep = xDiffOverStep + [zeros(1,iOverStep(i+1)+1), repmat(lengthOverStep(i),1,samplePointAmount-iOverStep(i+1)-1)];
end

if dynamic
    xRightOut = xRightIn - xDiff + xDiffOverStep;
    xLeftOut = xLeftIn - xDiff + xDiffOverStep;
else
    xRightOut = xRightIn;
    xLeftOut = xLeftIn;
end