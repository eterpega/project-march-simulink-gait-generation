function [xRight, yRight, xLeft, yLeft] = lock_x_stance_leg(xRight, ...
    yRight, xLeft, yLeft, stanceLegRight, stanceLegLeft)

xFootRight = xRight(1,:);
xFootLeft = xLeft(1,:);
samplePointAmount = length(xFootLeft);
xDiff = xFootRight .* stanceLegRight' + xFootLeft .* stanceLegLeft';

iOverStep = diff(stanceLegLeft);
iOverStep = [1 , find(iOverStep)'];
lengthOverStep = xFootLeft(iOverStep(2:end)) - xFootLeft(iOverStep(1:end-1));

xDiffOverStep = zeros(1,samplePointAmount);

for i = 1:(length(iOverStep)-1)
    xDiffOverStep = xDiffOverStep + [zeros(1,iOverStep(i+1)+1), repmat(lengthOverStep(i),1,samplePointAmount-iOverStep(i+1)-1)];
end

xRight = xRight - xDiff + xDiffOverStep;
xLeft = xLeft - xDiff + xDiffOverStep;