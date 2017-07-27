function max_velocities
%Find distance (in radians) from soft_stop where breaking is neceserry when
%at max velocity

%% define constants
global angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum 

I_ll = 0.7; %moment of inertia lowerleg [kg*m^2]
I_ul = 5.5; %moment of inertia upperleg [kg*m^2]
torqueMotor = 3; %max Torque of motor [Nm]
transmission = 101; %transmission from motor to joint [-]
efficiency = 0.8; %efficiency of transmission [-]

angleKnee = angleKneeEndStopMinimum:0.01:angleKneeEndStopMaximum;
angleHip = angleHipEndStopMinimum:0.01:angleHipEndStopMaximum;
%% Do calculations
% Maximum torque at joint
torqueJoint = transmission * torqueMotor * efficiency; %Maximum joint torque [Nm]

% maximum acceleration at joint
accelerationMaximumKnee = torqueJoint / I_ll;% [rad/s^2] %Maximum joint acceleration  lower leg [degree/s^2] 
accelerationMaximumHip = torqueJoint / I_ul; % [rad/s^2] Maximum joint acceleration upper leg [degree/s^2] 

%fprintf(['max acceleration upper leg = ', num2str(accelerationMaximumProximal), ' [rad/s^2]\nmax acceleration lower leg = ', num2str(accelerationMaximumDistal) , ' [rad/s^2]'])

velocityMaximumKneePositive = sqrt(2*accelerationMaximumKnee * (angleKneeEndStopMaximum - angleKnee));%[rad/s]
velocityMaximumHipPositive = sqrt(2*accelerationMaximumHip * (angleHipEndStopMaximum - angleHip));%[rad/s]
 
%for when we move in negative direction we have the soft_stop_min
velocityMaximumKneeNegative = -sqrt(2*accelerationMaximumKnee * (angleKnee - angleKneeEndStopMinimum));%[rad/s]
velocityMaximumHipNegative = -sqrt(2*accelerationMaximumHip * (angleHip - angleHipEndStopMinimum));%[rad/s]

velocityMaximum = 17; %[RPM]
velocityMaximumKneePositive = velocityMaximumKneePositive/(2*pi)*60;
velocityMaximumHipPositive = velocityMaximumHipPositive/(2*pi)*60;
velocityMaximumKneeNegative = velocityMaximumKneeNegative/(2*pi)*60;
velocityMaximumHipNegative = velocityMaximumHipNegative/(2*pi)*60;

velocityMaximumKneePositive = max()

figure; 
subplot(2,1,1)
hold on
plot(angleKnee, velocityMaximumKneePositive)
plot(angleKnee, velocityMaximum)
plot(angleKnee, velocityMaximumKneeNegative)
plot(angleKnee, -velocityMaximum)
ylabel 'angular speed [rpm]'
xlabel ' angular position [rad]'
legend ('maximum allowable speed', 'absolute limit')
xlim([min(angleKnee), max(angleKnee)])
title 'Knee Joint'
grid on
hold off

subplot(2,1,2); hold on

plot(velocityMaximumHipPositive, [angleHipEndStopMinimum, angleHipEndStopMaximum], 'k' )
plot(velocityMaximum, [angleHipEndStopMinimum, angleHipEndStopMaximum], 'r')
plot(velocityMaximumHipNegative, [angleHipEndStopMinimum, angleHipEndStopMaximum], 'k')
plot(-velocityMaximum, [angleHipEndStopMinimum, angleHipEndStopMaximum], 'r')
ylabel 'angular speed [rpm]'
xlabel 'angular position [degrees]'
legend ('maximum allowable speed', 'absolute limit')
xlim([angleHipEndStopMinimum, angleHipEndStopMaximum])
title 'Hip Joint'
grid on
hold off