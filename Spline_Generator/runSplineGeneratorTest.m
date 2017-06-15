clc
close all
clear all
% all data comes in as [rad], [rad/s] etc.
sim('SplineGeneratorTest.slx') 

%Hip
y1_deg = f1.Data(1,:)/pi*180; %[deg]
dydx1_RPM = d1.Data(1,:)/pi*60; %[RPM]
d2ydx21_rads2 = s1.Data(1,:); %[rad/s^2]

%Knee
y2_deg = f2.Data(1,:)/pi*180; %[deg]
dydx2_RPM = d2.Data(1,:)/pi*180; %[RPM]
d2ydx22_rads2 = s2.Data(1,:); %[rad/s^2]

%Foot
x = generatedSplines.x.Data(1,:);
y = generatedSplines.y.Data(1,:);

%Phase and time
phase = 0:0.1:99.9;
time = (0:0.1:99.9)/100*4;
lstep = 0.3; %[m]

gaitFigure = figure('Position',[200,0,1000,800]);
title('Gait results')
subplot(3,2,1)
plot(phase,y1_deg,'Linewidth',2)
hold on
plot(phase,y2_deg,'Linewidth',2);
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
plot(time,dydx1_RPM,'Linewidth',2);
hold on
plot(time,dydx2_RPM,'Linewidth',2);
xlabel('Time [s]')
ylabel('Velocity [RPM]')
legend('Hip','Knee')
grid on

subplot(3,2,5)
title('Hip and Knee Acceleration')
plot(time,d2ydx21_rads2,'Linewidth',2);
hold on
plot(time,d2ydx22_rads2,'Linewidth',2);
xlabel('Time [s]')
ylabel('Acceleration [rad/s^2]')
legend('Hip','Knee')
grid on

subplot(3,2,6)
plot(y1_deg,dydx1_RPM,'Linewidth',2);
hold on
plot(y2_deg,dydx2_RPM,'Linewidth',2);
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
plot(generatedSplines.p.Data(1,:))
subplot(3,1,2)
plot(generatedSplines.dpdx.Data(1,:))
subplot(3,1,3)
plot(generatedSplines.d2pdx2.Data(1,:))
