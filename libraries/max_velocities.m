%Find distance (in radians) from soft_stop where breaking is neceserry when
%at max velocity
close all
clear all
clc

%% define constants
I_ll = 0.7; %moment of inertia lowerleg [kg*m^2]
I_ul = 5.5; %moment of inertia upperleg [kg*m^2]
torqueMotor = 3; %max Torque of motor [Nm]
transmission = 101; %transmission from motor to joint [-]
efficiency = 0.8; %efficiency of transmission [-]

% Insert endstops here
softStopMaximumProximal = 120;%[degree]
softStopMinimumProximal = 0; %[degree]

softStopMaximumDistal = 120;%[degree]
softStopMinimumDistal = 0; %[degree]

%% Do calculations
% Maximum torque at joint
torqueJoint = transmission * torqueMotor * efficiency; %Maximum joint torque [Nm]

% maximum acceleration at joint
accelerationMaximumDistal = torqueJoint / I_ll;% [rad/s^2] %Maximum joint acceleration  lower leg [degree/s^2] 
accelerationMaximumProximal = torqueJoint / I_ul; % [rad/s^2] Maximum joint acceleration upper leg [degree/s^2] 

%fprintf(['max acceleration upper leg = ', num2str(accelerationMaximumProximal), ' [rad/s^2]\nmax acceleration lower leg = ', num2str(accelerationMaximumDistal) , ' [rad/s^2]'])

% convert endstops into rad
softStopMaximumProximal = softStopMaximumProximal/180*pi;%[rad]
softStopMinimumProximal = softStopMinimumProximal/180*pi;%[rad]

softStopMaximumDistal = softStopMaximumDistal/180*pi;%[rad]
softStopMinimumDistal = softStopMinimumDistal/180*pi;%[rad]

syms angular_position
velocityMaximumDistalPositive = sqrt(2*accelerationMaximumDistal * (softStopMaximumDistal - angular_position));%[rad/s]
velocityMaximumProximalPositive = sqrt(2*accelerationMaximumProximal * (softStopMaximumProximal - angular_position));%[rad/s]
 
%for when we move in negative direction we have the soft_stop_min
velocityMaximumDistalNegative = -sqrt(2*accelerationMaximumDistal * (angular_position - softStopMinimumDistal));%[rad/s]
velocityMaximumProximalNegative = -sqrt(2*accelerationMaximumProximal * (angular_position - softStopMinimumProximal));%[rad/s]

velocityMaximum = 17; %[RPM]
velocityMaximumDistalPositive = velocityMaximumDistalPositive/(2*pi)*60;
velocityMaximumProximalPositive = velocityMaximumProximalPositive/(2*pi)*60;
velocityMaximumDistalNegative = velocityMaximumDistalNegative/(2*pi)*60;
velocityMaximumProximalNegative = velocityMaximumProximalNegative/(2*pi)*60;

figure; 
subplot(2,1,1)
hold on
fplot(velocityMaximumDistalPositive, [softStopMinimumDistal, softStopMaximumDistal], 'k' )
fplot(velocityMaximum, [softStopMinimumDistal, softStopMaximumDistal], 'r')
fplot(velocityMaximumDistalNegative, [softStopMinimumDistal, softStopMaximumDistal], 'k')
fplot(-velocityMaximum, [softStopMinimumDistal, softStopMaximumDistal], 'r')
ylabel 'angular speed [rpm]'
xlabel ' angular position [rad]'
legend ('maximum allowable speed', 'absolute limit')
xlim([softStopMinimumDistal, softStopMaximumDistal])
title 'Knee Joint'
grid on
hold off

subplot(2,1,2); hold on

fplot(velocityMaximumProximalPositive, [softStopMinimumProximal, softStopMaximumProximal], 'k' )
fplot(velocityMaximum, [softStopMinimumProximal, softStopMaximumProximal], 'r')
fplot(velocityMaximumProximalNegative, [softStopMinimumProximal, softStopMaximumProximal], 'k')
fplot(-velocityMaximum, [softStopMinimumProximal, softStopMaximumProximal], 'r')
ylabel 'angular speed [rpm]'
xlabel 'angular position [degrees]'
legend ('maximum allowable speed', 'absolute limit')
xlim([softStopMinimumProximal, softStopMaximumProximal])
title 'Hip Joint'
grid on
hold off