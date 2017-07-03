function [angleKneeMinimum, angleKneeMaximum] = limit_angle_knee_position_x(x, Lul, Lll)
% this function finds the maximum and minimum knee angle achivable given a
% certain x psotion

angleKneeEndStopMinimum = deg2rad(-10);
angleKneeEndStopMaximum = deg2rad(110);

% Endstops
angleHipEndStopMinimum = deg2rad(-10); %[rad] lowest endstop
angleHipEndStopMaximum = deg2rad(110); %[rad] maximum endstop
angleHip = linspace(angleHipEndStopMinimum, angleHipEndStopMaximum, 1000);

x = x(:)'; %should be row
angleHip = angleHip(:); %should be column

angleKnee = angleHip - asin((x-Lul*sin(angleHip))/Lll);

% https://nl.mathworks.com/matlabcentral/newsreader/view_thread/255392
angleKnee(~abs(imag(angleKnee))< eps('double').*abs(real(angleKnee))) = nan;

angleKneeMinimum = min(angleKnee, [], 1);
angleKneeMaximum = max(angleKnee, [], 1);


angleKneeMinimum(angleKneeMinimum < angleKneeEndStopMinimum) =  angleKneeEndStopMinimum;
angleKneeMaximum(angleKneeMinimum < angleKneeEndStopMaximum) =  angleKneeEndStopMaximum;