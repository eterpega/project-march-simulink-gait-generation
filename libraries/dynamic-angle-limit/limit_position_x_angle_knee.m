function [positionXMinimum, positionXMaximum]= limit_position_x_angle_knee(angleKnee, Lul, Lll)
% this function finds the maximum and minimum x position achivable given a
% certain knee angle

% Endstops
angleHipEndStopMinimum = deg2rad(-10); %[rad] lowest endstop
angleHipEndStopMaximum = deg2rad(110); %[rad] maximum endstop
angleHip = linspace(angleHipEndStopMinimum, angleHipEndStopMaximum, 1000);

angleKnee = angleKnee(:)'; %should be row
angleHip = angleHip(:); %should be column

positionX = Lul * sin(angleHip) + Lll * sin(angleHip - angleKnee);

positionXMinimum = min(positionX, [], 1);
positionXMaximum = max(positionX, [], 1);