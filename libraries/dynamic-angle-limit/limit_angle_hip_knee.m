function [angleHipMinimum, angleHipMaximum]  = limit_angle_hip_knee(angleKnee)

samplesAmount = length(angleKnee);

angleHipMinimum = nan(1,samplesAmount);
angleHipMaximum = nan(1,samplesAmount);
end