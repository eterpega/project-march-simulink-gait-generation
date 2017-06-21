close all
clear all
clc

selected1 = [0 ,1, 0, 0]; %[Hip, Knee, x, y];
selected2 = [0 ,0, 1, 0]; %[Hip, Knee, x, y];

selected = selected1 + selected2; %knee and x selected

keyEventHipPhase = [55, 85]; %hip angle: for test look_up_hip_y
keyEventHipAngle = [-7, 20]/180*pi; %hip angle: for test look_up_hip_y
keyEventHipdAngle = [0,0]; %hip angle: for test look_up_hip_y

keyEventKneePhase = [0, 18, 45, 78];   %knee angle: for test look_up_hip_y
keyEventKneeAngle = [0, 15, 2, 60]/180*pi;  %knee angle: for test look_up_hip_y 
keyEventKneedAngle = [0,0, 0 ,0]; %knee angle: for test look_up_hip_y

keyEventxPhase = [0, 18, 45, 62];
keyEventxPos = [0.15, 0.0, -0.1, -0.25]; %[m] x position: for test look_up_hip_y
keyEventxdPos = [0, -0.0035, -0.0035, 0]; % x position: for test look_up_hip_y

if selected1(1)
    keyEvent1Phase = keyEventHipPhase;
    keyEvent1y = keyEventHipAngle;
    keyEvent1dy = keyEventHipdAngle;
elseif selected1(2)
    keyEvent1Phase = keyEventKneePhase; 
    keyEvent1y = keyEventKneeAngle;
    keyEvent1dy = keyEventKneedAngle;
elseif selected1(3)  
    keyEvent1Phase = keyEventxPhase;
    keyEvent1y = keyEventxPos;
    keyEvent1dy = keyEventxdPos;
elseif selected1(4)    
    keyEvent1Phase = keyEventyPhase; 
    keyEvent1y = keyEventxPos;
    keyEvent1dy = keyEventxdAngle;
end

if selected2(1)
    keyEvent2Phase = keyEventHipPhase;
    keyEvent2y = keyEventHipAngle;
    keyEvent2dy = keyEventHipdAngle;
elseif selected2(2)
    keyEvent2Phase = keyEventKneePhase; 
    keyEvent2y = keyEventKneeAngle;
    keyEvent2dy = keyEventKneedAngle;
elseif selected2(3)  
    keyEvent2Phase = keyEventxPhase;
    keyEvent2y = keyEventxPos;
    keyEvent2dy = keyEventxdPos;
elseif selected2(4)    
    keyEvent2Phase = keyEventyPhase; 
    keyEvent2y = keyEventxPos;
    keyEvent2dy = keyEventxdAngle;
end

keyEvent1Number = length(keyEvent1Phase);
keyEvent1PhaseOut = [keyEvent1Phase, nan(1,20-keyEvent1Number)];
keyEvent1yOut = [keyEvent1y, nan(1,20-keyEvent1Number)];
keyEvent1dyOut = [keyEvent1dy, nan(1,20-keyEvent1Number)];

keyEvent2Number = length(keyEvent2Phase);
keyEvent2PhaseOut = [keyEvent2Phase, nan(1,20-keyEvent2Number)];
keyEvent2yOut = [keyEvent2y, nan(1,20-keyEvent2Number)];
keyEvent2dyOut = [keyEvent2dy, nan(1,20-keyEvent2Number)];

keyEvent1 = [keyEvent1Phase;keyEvent1y;keyEvent1dy];
keyEvent2 = [keyEvent2Phase;keyEvent2y;keyEvent2dy];

%function luca_draws_splines(handles)

%[keyEvent1, keyEvent2, selected] = get_gait_data(handles)

[angleHip, angleKnee, x, y, foot] = drawspline(keyEvent1, keyEvent2, selected);

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

