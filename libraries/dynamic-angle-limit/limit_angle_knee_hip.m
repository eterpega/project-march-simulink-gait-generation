function [angleKneeMinimum, angleKneeMaximum]  = limit_angle_knee_hip(angleHip)

samplesAmount = length(angleHip);

angleKneeMinimum = nan(1,samplesAmount);
angleKneeMaximum = nan(1,samplesAmount);
end