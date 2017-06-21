function [angleHip, angleKnee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength] = drawspline(keyEvent1, keyEvent2, selected)
% This function takes certain key events and uses them to draw a line trough
% them. the general concept is explained at:
% https://confluence.projectmarch.nl:8443/display/05TECH/01-First+gait+generator
% 
% The key events should be given like:
%
% [phase_1,      phase_2,        ...,    phase_n    ]
% [position_1,   position_2,     ...,    position_n ]
% [dposition_1,  dposition_2,    ...,    dposition_2]
%
% Selected is e vector saying which of the four design parameters are
% selected. Selected should look like:
%
% [angleHip, angleKnee, x, y]
%
% if high , tyhan this parameter is selected.
%
% keyEvent1Amount = size(keyEvent1,2);
% keyEvent2Amount = size(keyEvent2,2);

% Create phase vector. 
samplePointAmount = 1000; %this will determine the speed, this shouldn't be defined here!
plotPhase = linspace(0,99.9,samplePointAmount); %[%] Phase goes from 0 to 99.9... %
t = 0.1*4/100; %[s/%] the speed at which a gait will be played back, this shouldn't be defined here!

% The first key event is copied and moved 100% further so a continious gait
% can be generated.
keyEvent1 = add_last_key_event(keyEvent1);
keyEvent2 = add_last_key_event(keyEvent2);

% The plot phase needs to be moved, we want to interpolate from the key
% event to the last key event.
plotPhase1 = keyEvent1(1,1) + plotPhase; %[%]
plotPhase2 = keyEvent2(1,1) + plotPhase; %[%]

%% Interpolater
% over here we interpolate between the different key events
spline1 = hermite_cubic_spline_value( keyEvent1,plotPhase1);
spline2 = hermite_cubic_spline_value( keyEvent2,plotPhase2);

% Since we want to define the gait from 0 to 100 percent we cut the part
% after 100% and paste it after 0%.
[spline1,plotPhase1] = rearrange_from_zero_to_hundered(spline1, plotPhase1);
[spline2,plotPhase2] = rearrange_from_zero_to_hundered(spline2, plotPhase2);

if plotPhase1 ~= plotPhase2
    warning('the phases are not equal, something went wrong.')
end

%% Inverse kinematics
% We now apply inverse kinematics to determine all the gait parameters.
% see: https://confluence.projectmarch.nl:8443/display/05TECH/04-%28Inverse%29+Kinematics
[x.x, y.y, angleKnee.angleKnee, angleHip.angleHip] = kinematics(spline1, spline2, selected);

%% Coordinate transform
% Now we transform the coordinate system from the hip to the ground since
% this will give us much more inforamtion, first we need to determine the
% stance leg, than the transformation is applied.
%see: https://confluence.projectmarch.nl:8443/display/05TECH/05-Coordinate+transform
[stanceLegRight, stanceLegLeft] = stance_leg(y.y);
[y.y] =  transform_to_ground(y.y,angleHip.angleHip,angleKnee.angleKnee, stanceLegLeft);
foot.foot = foot_position(x.x,y.y);

%%Determine step length
stepLength = step_length(x.x, stanceLegRight);

%% Derivation
% all velocities, accelerations, and jerks are determined to check if they
% meet the possible joint outputs
[x.x, x.dx, x.ddx, x.dddx] = derivatives(x.x,t);
[y.y, y.dy, y.ddy, y.dddy] = derivatives(y.y,t);
[foot.foot, foot.dfoot, foot.ddfoot, foot.dddfoot] = derivatives(foot.foot,t);
[angleKnee.angleKnee, angleKnee.dangleKnee, angleKnee.ddangleKnee, angleKnee.dddangleKnee] = derivatives(angleKnee.angleKnee,t);
[angleHip.angleHip, angleHip.dangleHip, angleHip.ddangleHip, angleHip.dddangleHip] = derivatives(angleHip.angleHip,t);