%clc
%close all
%clear all
% all data comes in as [rad], [rad/s] etc.

%sim('SplineGeneratorTest.slx') 
%%
%angleHip
angleHip_deg = angleHip.angleHip/pi*180; %[deg]
angleHip_RPM = angleHip.dangleHip/pi*60; %[RPM]
angleHip_rads2 = angleHip.ddangleHip; %[rad/s^2]

%angleKnee
angleKnee_deg = angleKnee.angleKnee/pi*180; %[deg]
angleKnee_RPM = angleKnee.dangleKnee/pi*180; %[RPM]
angleKnee_rads2 = angleKnee.ddangleKnee; %[rad/s^2]

%Foot
x = x.x;
y = y.y;
foot_p = foot.foot;
foot_v = foot.dfoot;
foot_a = foot.ddfoot;

%Phase and time
phase = 0:0.1:99.9;
time = (0:0.1:99.9)/100*4;
lstep = 0.3; %[m]

gaitFigure = figure('Position',[200,0,1000,800]);
title('Gait results')
subplot(3,2,1)
plot(phase,angleHip_deg,'Linewidth',2)
hold on
plot(phase,angleKnee_deg,'Linewidth',2);
xlabel('Phase [%]')
ylabel('Angle [degree]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,2)
plot(phase,x,'Linewidth',2)
hold on
plot(phase,y,'Linewidth',2)
legend('x','y')
xlabel('Phase [%]')
ylabel('position [m]')
grid on

subplot(3,2,3)
title('x vs y')
p3 = plot(x,y,'Linewidth',2);
xlabel('x [m]')
ylabel('y [m]')
grid on

subplot(3,2,4)
title('angleHip and angleKnee Velocity')
plot(time,angleHip_RPM,'Linewidth',2);
hold on
plot(time,angleKnee_RPM,'Linewidth',2);
xlabel('Time [s]')
ylabel('Velocity [RPM]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,5)
title('angleHip and angleKnee Acceleration')
plot(time,angleHip_rads2,'Linewidth',2);
hold on
plot(time,angleKnee_rads2,'Linewidth',2);
xlabel('Time [s]')
ylabel('Acceleration [rad/s^2]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,6)
plot(angleHip_deg,angleHip_RPM,'Linewidth',2);
hold on
plot(angleKnee_deg,angleKnee_RPM,'Linewidth',2);
legend('angleHip','angleKnee')
title('angleHip and angleKnee Acceleration')
xlabel('Angle [deg]')
ylabel('Velocity [RPM]')
grid on

%// modified jet-colormap
cd = [uint8(jet(1000)*255) uint8(ones(1000,1))]'; 
drawnow
set(p3.Edge, 'ColorBinding','interpolated', 'ColorData',cd)
%saveas(gaitFigure,'GaitResults.jpg')

figure
subplot(3,1,1)
plot(foot_p)
title('Foot Position (m) (x*y)')
subplot(3,1,2)
plot(foot_v)
title('Foot Velocity (m/s)')
subplot(3,1,3)
plot(foot_a)
title('Foot Acceleration (m^2/s)')

