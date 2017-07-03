function [angleHipMinimum, angleHipMaximum]  = limit_angle_hip(angleKnee)

samplesAmount = length(angleKnee);

angleHipMinimum = nan(samplesAmount);
angleHipMaximum = nan(samplesAmount);
end