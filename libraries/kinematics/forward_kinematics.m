function [x,y] = forward_kinematics(angleHip,angleKnee)

global LProximal LDistal

x1 = LProximal*sin(angleHip); %[m]
y1 = LProximal*cos(angleHip); %[m]

x2 = -LDistal * cos(0.5*pi+angleHip - angleKnee); %[m]
y2 = LDistal * sin(0.5*pi+angleHip - angleKnee); %[m]

x = x1 + x2; %[m]
y = y1 + y2; %[m]