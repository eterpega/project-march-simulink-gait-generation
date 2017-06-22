close all
clear all
clc

%% First give an input which design spline has bee slected
selected1 = [0 ,1, 0, 0]; %[Hip, Knee, x, y];
selected2 = [0 ,0, 1, 0]; %[Hip, Knee, x, y];

selected = selected1 + selected2; %this vecotr contains both selected

%% We create some key venet vectors based on some data from a reasearch
keyEventHipPhase = [55, 85]; %[%]
keyEventHipAngle = [-7, 20]/180*pi; %[rad]
keyEventHipdAngle = [0,0]; %[rad/%] 

keyEventKneePhase = [0, 18, 45, 78];   %[%]
keyEventKneeAngle = [0, 15, 2, 60]/180*pi;  %[rad]
keyEventKneedAngle = [0,0, 0 ,0]; %[rad/%]

keyEventXPhase = [0, 18, 45, 62]; %[%]
keyEventXPos = [0.15, 0.0, -0.1, -0.25]; %[m]
keyEventXdPos = [0, -0.0035, -0.0035, 0]; %[m/%]

keyEventHip = [keyEventHipPhase;keyEventHipAngle;keyEventHipdAngle];
keyEventKnee = [keyEventKneePhase;keyEventKneeAngle;keyEventKneedAngle];
keyEventX = [keyEventXPhase;keyEventXPos;keyEventXdPos];

%% Select the right key event data, it is done a bit ugly, but is just used for testing
if selected1(1)
    keyEvent1 = keyEventHip;
elseif selected1(2)
    keyEvent1 = keyEventKnee;
elseif selected1(3)  
    keyEvent1 = keyEventX;
elseif selected1(4)    
    keyEvent1 = keyEventY; 
end

if selected2(1)
    keyEvent2 = keyEventHip;
elseif selected2(2)
    keyEvent2 = keyEventKnee;
elseif selected2(3)  
    keyEvent2 = keyEventX;
elseif selected2(4)    
    keyEvent2 = keyEventY;
end


% Create phase vector. 
sampleFrequency = 1000; %[Hz] sample frequency of SLRT model
stepTime = 1.5; %[s] Time it takes for 1 setp
strideTime = stepTime*2; %[s]
samplePointAmount = strideTime*sampleFrequency; %this will determine the speed
tInterval = strideTime/samplePointAmount; %[s] The difference in time between each interval

phase = linspace(0,99.9,samplePointAmount); %[%] Phase goes from 0 to 99.9... %
time = phase*strideTime/100; %[s] Time vector

%% Calculate Gait
[angleHip, angleKnee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength] = gait_calculator(keyEvent1, keyEvent2, selected, phase, tInterval);


%% Process data
%angleHip
angleHip_deg = angleHip.angleHip/(2*pi)*360; %[deg]
angleHip_RPM = angleHip.dangleHip/(2*pi)*60; %[RPM]
angleHip_rads2 = angleHip.ddangleHip; %[rad/s^2]

%angleKnee
angleKnee_deg = angleKnee.angleKnee/(2*pi)*360; %[deg]
angleKnee_RPM = angleKnee.dangleKnee/(2*pi)*60; %[RPM]
angleKnee_rads2 = angleKnee.ddangleKnee; %[rad/s^2]

%Foot
x = x.x;
y = y.y;
foot_p = foot.foot;
foot_v = foot.dfoot;
foot_a = foot.ddfoot;


%% Plot results
gaitFigure = figure('Position',[200,0,1000,800]);
subplot(3,2,1)
plot(time,angleHip_deg,'Linewidth',2)
hold on
plot(time,angleKnee_deg,'Linewidth',2);
title('Joint angles')
xlabel('Time [s]')
ylabel('Angle [degree]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,2)
plot(phase,x,'Linewidth',2)
hold on
plot(phase,y,'Linewidth',2)
title('Foot Positions')
legend('x','y')
xlabel('Time [s]')
ylabel('position [m]')
grid on

subplot(3,2,3)
plot(time,angleHip_RPM,'Linewidth',2);
hold on
plot(time,angleKnee_RPM,'Linewidth',2);
title('Hip and Knee Angular Velocity')
xlabel('Time [s]')
ylabel('Velocity [RPM]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,4)
p3 = plot(x,y,'Linewidth',2);
title('Foot Position Side View')
xlabel('x [m]')
ylabel('y [m]')
grid on

subplot(3,2,5)
plot(time,angleHip_rads2,'Linewidth',2);
hold on
plot(time,angleKnee_rads2,'Linewidth',2);
title('Hip and Knee Angular Acceleration')
xlabel('Time [s]')
ylabel('Acceleration [rad/s^2]')
legend('angleHip','angleKnee')
grid on

subplot(3,2,6)
plot(angleHip_deg,angleHip_RPM,'Linewidth',2);
hold on
plot(angleKnee_deg,angleKnee_RPM,'Linewidth',2);
legend('angleHip','angleKnee')
title('Hip and Knee Velocity vd Angle')
xlabel('Angle [deg]')
ylabel('Velocity [RPM]')
grid on

%Color side view with stride
cd = [uint8(jet(samplePointAmount)*255) uint8(ones(samplePointAmount,1))]'; 
drawnow
set(p3.Edge, 'ColorBinding','interpolated', 'ColorData',cd)

%% Plot foot position, velcity and acceleration
figure
subplot(3,1,1)
plot(time, foot_p)
title('Foot Position')
xlabel('Time [s]')
ylabel('Position [m]')
grid on

subplot(3,1,2)
plot(time, foot_v)
title('Foot Velocity (m/s)')
xlabel('Time [s]')
ylabel('Velocity [m/s]')
grid on

subplot(3,1,3)
plot(time, foot_a)
title('Foot Acceleration (m^2/s)')
xlabel('Time [s]')
ylabel('Position [m]')
grid on

figure('Position',[200,200,800,300])
plot(time, stanceLegRight,'Linewidth',3)
hold on
plot(time, stanceLegLeft,'Linewidth',3)
title('Stance and swing leg')
xlabel('Time [s]')
legend('Right leg is stance leg','Right leg is swing leg')
axis([0, max(time), -0.2, 1.2])
grid on

disp(stepLength/stepTime);

