function detail_plots(phase, angleHip_deg, angleKnee_deg, x, y,...
    velocityHip_RPM, velocityKnee_RPM, accelerationHip_rads2, ...
    accelerationKnee_rads2, time, samplePointAmount)

global velocityMaximumHip

%% Make figure 
gaitFigure = figure('Position',[200,0,1000,800]);

%% Joint angles
subplot(3,2,1)
plot(phase,angleHip_deg,'Linewidth',2)
hold on
plot(phase,angleKnee_deg,'Linewidth',2);
title('Joint Angle')
xlabel('Time [s]')
ylabel('Angle [degree]')
legend('angleHip','angleKnee')
grid on

%% Angular velocity
subplot(3,2,3)
plot(time,velocityHip_RPM,'Linewidth',2);
hold on
plot(time,velocityKnee_RPM,'Linewidth',2);
title('Hip and Knee Angular Velocity')
xlabel('Time [s]')
ylabel('Velocity [RPM]')
legend('angleHip','angleKnee')
hold on
plot(time,repmat(rads2RPM(velocityMaximumHip) ,length(time),1),'Linewidth',2,'Color','r')
hold on
plot(time,repmat(rads2RPM(-velocityMaximumHip),length(time),1),'Linewidth',2,'Color','r')
grid on

%% Angular acceleration
subplot(3,2,5)
plot(time,accelerationHip_rads2,'Linewidth',2);
hold on
plot(time,accelerationKnee_rads2,'Linewidth',2);
title('Hip and Knee Angular Acceleration')
xlabel('Time [s]')
ylabel('Acceleration [rad/s^2]')
legend('angleHip','angleKnee')
grid on

%% Position
subplot(3,2,2)
plot(phase,x,'Linewidth',2)
hold on
plot(phase,y,'Linewidth',2)
title('Foot Position')
legend('x','y')
xlabel('Time [s]')
ylabel('position [m]')
grid on

%% Position
subplot(3,2,4)
p3 = plot(x,y,'Linewidth',2);
title('Foot Position Side View')
xlabel('x [m]')
ylabel('y [m]')
grid on

%% Velocity vs angle
subplot(3,2,6)
plot(angleHip_deg,velocityHip_RPM,'Linewidth',2);
hold on
plot(angleKnee_deg,velocityKnee_RPM,'Linewidth',2);
legend('angleHip','angleKnee')
title('Hip and Knee Velocity vs Angle')
xlabel('Angle [deg]')
ylabel('Velocity [RPM]')
grid on

%Color side view with stride
cd = [uint8(jet(samplePointAmount)*255) uint8(ones(samplePointAmount,1))]'; 
drawnow
set(p3.Edge, 'ColorBinding','interpolated', 'ColorData',cd)