function [positionXMinimum, positionXMaximum]= limit_position_x_angle_knee(angleKnee)
% this function finds the maximum and minimum x position achivable given a
% certain knee angle

global LProximal LDistal angleHipEndStopMinimum angleHipEndStopMaximum

% Endstops
angleHip = linspace(angleHipEndStopMinimum, angleHipEndStopMaximum, 1000);

angleKnee = angleKnee(:)'; %should be row
angleHip = angleHip(:); %should be column

positionX = LProximal * sin(angleHip) + LDistal * sin(angleHip - angleKnee);

positionXMinimum = min(positionX, [], 1);
positionXMaximum = max(positionX, [], 1);