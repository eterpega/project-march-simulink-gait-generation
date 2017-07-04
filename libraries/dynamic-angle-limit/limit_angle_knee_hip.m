function [angleKneeMinimum, angleKneeMaximum]  = limit_angle_knee_hip(angleHip)

samplesAmount = length(angleHip);

angleKneeMinimum = nan(samplesAmount);
angleKneeMaximum = nan(samplesAmount);
end