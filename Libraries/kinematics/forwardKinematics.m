function [x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll)
x1 = Lul*sin(angleHip); %[m]
y1 = Lul*cos(angleHip); %[m]

x2 = -Lll * cos(0.5*pi+angleHip - angleKnee); %[m]
y2 = Lll * sin(0.5*pi+angleHip - angleKnee); %[m]

x = x1 + x2; %[m]
y = y1 + y2; %[m]