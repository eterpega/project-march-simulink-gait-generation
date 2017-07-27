function [angleKneeMinimum, angleKneeMaximum] = limit_angle_knee_position_x(x)
% this function finds the maximum and minimum knee angle achivable given a
% certain x psotion
%0.08
%% Load all required global parameters
global LProximal LDistal angleKneeEndStopMinimum angleKneeEndStopMaximum...
    angleHipEndStopMinimum angleHipEndStopMaximum

%% Possible hip angles
% We will move the hip angle over all possible positions to see what is
% possible
angleHip = linspace(angleHipEndStopMinimum, angleHipEndStopMaximum, 1000); %[rad]

%% Make sure both x and hip angle vecotr are in the right dimensions
x = x(:)'; %[m] should be row
angleHip = angleHip(:); %[rad] should be column

%% Find knee angle
% We look for the required knee angle to reach the hipangle and x 
% requirements
angleKnee = angleHip - asin((x-LProximal*sin(angleHip))/LDistal); %[rad]

%% Remove complex solutions
% Some angles we found are complex, these should be removed since they are
% not achivable
angleKnee(angleKnee ~= real(angleKnee)) = nan;

%% Look for limits
% We now look for the limits over all possible hip angles, we need the
% minimum and maximum limits.
angleKneeMinimum = min(angleKnee, [], 1);
angleKneeMaximum = max(angleKnee, [], 1);

%% Apply end-stops
% Many angles we find may lie outside the endstop range, in this case set
% it equal to the end-stop
angleKneeMinimum(angleKneeMinimum < angleKneeEndStopMinimum) =  angleKneeEndStopMinimum;
angleKneeMaximum(angleKneeMinimum < angleKneeEndStopMaximum) =  angleKneeEndStopMaximum;
