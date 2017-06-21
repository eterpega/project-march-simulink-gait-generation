function []= RunSimulation(fighandle)
%Close all figures except GUI
set(fighandle, 'HandleVisibility', 'off');
close all
set(fighandle, 'HandleVisibility', 'on');
clear all
clc

sim('SplineGeneratorTest') 
%%
%Hip
hip_deg = hip.hip.Data(1,:)/pi*180; %[deg]
hip_RPM = hip.dhip.Data(1,:)/pi*60; %[RPM]
hip_rads2 = hip.ddhip.Data(1,:); %[rad/s^2]

%Knee
knee_deg = knee.knee.Data(1,:) /pi*180; %[deg]
knee_RPM = knee.dknee.Data(1,:)/pi*180; %[RPM]
knee_rads2 = knee.ddknee.Data(1,:); %[rad/s^2]

%Foot
x = x.x.Data(1,:);
y = y.y.Data(1,:);
foot_p = foot.foot.Data(1,:);
foot_v = foot.dfoot.Data(1,:);
foot_a = foot.ddfoot.Data(1,:);

%Phase and time
phase = 0:0.1:99.9;
time = (0:0.1:99.9)/100*4;
lstep = 0.3; %[m]

gaitFigure = figure('Position',[200,0,1000,800]);
title('Gait results')
subplot(3,2,1)
plot(phase,hip_deg,'Linewidth',2)
hold on
plot(phase,knee_deg,'Linewidth',2);
xlabel('Phase [%]')
ylabel('Angle [degree]')
legend('Hip','Knee')
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
title('Hip and Knee Velocity')
plot(time,hip_RPM,'Linewidth',2);
hold on
plot(time,knee_RPM,'Linewidth',2);
xlabel('Time [s]')
ylabel('Velocity [RPM]')
legend('Hip','Knee')
grid on

subplot(3,2,5)
title('Hip and Knee Acceleration')
plot(time,hip_rads2,'Linewidth',2);
hold on
plot(time,knee_rads2,'Linewidth',2);
xlabel('Time [s]')
ylabel('Acceleration [rad/s^2]')
legend('Hip','Knee')
grid on

subplot(3,2,6)
plot(hip_deg,hip_RPM,'Linewidth',2);
hold on
plot(knee_deg,knee_RPM,'Linewidth',2);
legend('Hip','Knee')
title('Hip and Knee Acceleration')
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