function [angleKneeMinimum, angleKneeMaximum]  = limit_angle_Knee(angleHip)

samplesAmount = length(angleHip);

angleKneeMinimum = nan(samplesAmount);
angleKneeMaximum = nan(samplesAmount);
end