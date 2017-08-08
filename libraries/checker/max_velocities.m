function [velocityCurveMaximumKnee, velocityCurveMinimumKnee ,...
    velocityCurveMaximumHip, velocityCurveMinimumHip, angleKnee, ...
    angleHip] = max_velocities
%Find distance (in radians) from soft_stop where breaking is neceserry when
%at max velocity

%% define constants
global angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum velocityMaximumHip

I_ll = 1; %moment of inertia lowerleg [kg*m^2]
I_ul = 8.5; %moment of inertia upperleg [kg*m^2]
torqueMotor = 2; %max Torque of motor [Nm]
transmission = 101; %transmission from motor to joint [-]
efficiency = 0.8; %efficiency of transmission [-]

angleKnee = angleKneeEndStopMinimum:0.001:angleKneeEndStopMaximum;
angleHip = angleHipEndStopMinimum:0.001:angleHipEndStopMaximum;
%% Do calculations
% Maximum torque at joint
torqueJoint = transmission * torqueMotor * efficiency; %Maximum joint torque [Nm]

% maximum acceleration at joint
accelerationMaximumKnee = torqueJoint / I_ll;% [rad/s^2] %Maximum joint acceleration  lower leg [degree/s^2] 
accelerationMaximumHip = torqueJoint / I_ul; % [rad/s^2] Maximum joint acceleration upper leg [degree/s^2] 

velocityCurveMaximumKnee = sqrt(2*accelerationMaximumKnee * (angleKneeEndStopMaximum - angleKnee));%[rad/s]
velocityCurveMaximumHip = sqrt(2*accelerationMaximumHip * (angleHipEndStopMaximum - angleHip));%[rad/s]
 
%for when we move in negative direction we have the soft_stop_min
velocityCurveMinimumKnee = -sqrt(2*accelerationMaximumKnee * (angleKnee - angleKneeEndStopMinimum));%[rad/s]
velocityCurveMinimumHip = -sqrt(2*accelerationMaximumHip * (angleHip - angleHipEndStopMinimum));%[rad/s]

velocityCurveMaximumKnee = rads2RPM(min(velocityCurveMaximumKnee,velocityMaximumHip));
velocityCurveMinimumKnee = rads2RPM(max(velocityCurveMinimumKnee, -velocityMaximumHip));

velocityCurveMaximumHip = rads2RPM(min(velocityCurveMaximumHip,velocityMaximumHip));
velocityCurveMinimumHip = rads2RPM(max(velocityCurveMinimumHip, -velocityMaximumHip));
end