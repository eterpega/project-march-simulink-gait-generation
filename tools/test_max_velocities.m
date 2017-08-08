%Find distance (in radians) from soft_stop where breaking is neceserry when
%at max velocity
close all
clear all
clc

%% Define global parameters
global LProximal LDistal angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum sampleFrequency ...
    velocityMaximumKnee velocityMaximumHip stepTime gaitType ...
    accelerationMaximumHip accelerationMaximumKnee

% leg length
LProximal = 0.48; %[m] Length of upper leg, still has to be set correctly!
LDistal = 0.565; %[m]  Length of lower leg, still has to be set correctly!

sampleFrequency = 500; %[Hz] sample frequency of SLRT model

% angle maximum (end stops)
angleKneeEndStopMinimum = deg2rad(-5); %[rad]
angleKneeEndStopMaximum = deg2rad(115); %[rad]
angleHipEndStopMinimum = deg2rad(-20); %[rad]
angleHipEndStopMaximum = deg2rad(100); %[rad]

% velocity maximum
velocityMaximumHip = RPM2rads(17); %[rad/s]
velocityMaximumKnee = RPM2rads(17); %[rad/s]

% acceleration maximum
inertiaLeg = 10; %[kg*m^2]
inertiaLowerLeg = 1.5; %[kg*m^2]
torqueJoint = 200; %[Nm]
accelerationMaximumHip = torqueJoint/inertiaLeg; %[rad/s^2]
accelerationMaximumKnee = torqueJoint/inertiaLowerLeg; %[rad/s^2]


%% Do calculations
[velocityCurveMaximumKnee, velocityCurveMinimumKnee ,...
    velocityCurveMaximumHip, velocityCurveMinimumHip, angleKnee, ...
    angleHip] = max_velocities;

figure; 
subplot(2,1,1)
hold on
plot(rad2deg(angleHip), velocityCurveMaximumHip, 'k')
plot(rad2deg(angleHip), repmat(rads2RPM(velocityMaximumHip),length(angleHip)), 'r')
plot(rad2deg(angleHip), velocityCurveMinimumHip, 'k')
plot(rad2deg(angleHip), repmat(rads2RPM(-velocityMaximumHip),length(angleHip)), 'r')
ylabel 'angular speed [rpm]'
xlabel ' angular position [deg]'
legend ('Limit due to endstop', 'Limit due to power train','Location','eastoutside')
xlim([rad2deg(angleHipEndStopMinimum), rad2deg(angleHipEndStopMaximum)])
title 'Hip Joint'
grid on
hold off

subplot(2,1,2); hold on
plot(rad2deg(angleKnee), velocityCurveMaximumKnee, 'k')
plot(rad2deg(angleKnee), repmat(rads2RPM(velocityMaximumKnee),length(angleKnee)), 'r')
plot(rad2deg(angleKnee), velocityCurveMinimumKnee, 'k')
plot(rad2deg(angleKnee), repmat(rads2RPM(-velocityMaximumKnee),length(angleKnee)), 'r')
ylabel 'angular speed [rpm]'
xlabel ' angular position [deg]'
legend ('Limit due to endstop', 'Limit due to power train','Location','eastoutside')
xlim([rad2deg(angleKneeEndStopMinimum), rad2deg(angleKneeEndStopMaximum)])
title 'Knee Joint'
grid on
hold off