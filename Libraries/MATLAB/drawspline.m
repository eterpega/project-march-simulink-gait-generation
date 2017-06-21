function [angleHip, angleKnee, x, y, foot] = drawspline(keyEvent1, keyEvent2, selected)

keyEvent1Amount = size(keyEvent1,2);
keyEvent2Amount = size(keyEvent2,2);

% Create phase vector
plotPhase = (0:0.1:99.9)'; %[%] Phase goes from 0 to 99.9... %
t = 0.1*4/100; %[s]

keyEvent1 = add_last_key_event(keyEvent1);
keyEvent2 = add_last_key_event(keyEvent2);


%% Interpolater
%over here we interpolate between the different key events
%function [ f, d, s, t, plotPhase ] = interpolator( keyEventAmount, keyEventPhase, keyEventy, keyEventdy, numberSamplePoints)

plotPhase = keyEvent1(1,1) + plotPhase;

spline1 = hermite_cubic_spline_value( keyEvent1,plotPhase);
spline2 = hermite_cubic_spline_value( keyEvent2,plotPhase);

[spline1, plotPhase] = rearrange_from_zero_to_hundered(spline1, plotPhase);
[spline2, plotPhase] = rearrange_from_zero_to_hundered(spline2, plotPhase);

[x.x, y.y, angleKnee.angleKnee, angleHip.angleHip] = kinematics(spline1, spline2, selected);
[stanceLegRight, stanceLegLeft] = stance_leg(y.y);
[y.y] =  transform_to_ground(y.y,angleHip.angleHip,angleKnee.angleKnee, stanceLegLeft);
foot.foot = foot_position(x.x,y.y);

%% Inverse kinematics
[x.x, x.dx, x.ddx, x.dddx] = derivatives(x.x,t);
[y.y, y.dy, y.ddy, y.dddy] = derivatives(y.y,t);
[foot.foot, foot.dfoot, foot.ddfoot, foot.dddfoot] = derivatives(foot.foot,t);
[angleKnee.angleKnee, angleKnee.dangleKnee, angleKnee.ddangleKnee, angleKnee.dddangleKnee] = derivatives(angleKnee.angleKnee,t);
[angleHip.angleHip, angleHip.dangleHip, angleHip.ddangleHip, angleHip.dddangleHip] = derivatives(angleHip.angleHip,t);