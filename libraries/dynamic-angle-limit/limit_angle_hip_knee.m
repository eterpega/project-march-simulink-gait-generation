function [angleHipMinimum, angleHipMaximum]  = limit_angle_hip_knee(angleKnee)

samplesAmount = length(angleKnee);

angleHipMinimum = nan(samplesAmount);
angleHipMaximum = nan(samplesAmount);
end