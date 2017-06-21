function [x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll)
x1 = Lul*sin(angleHip);
y1 = Lul*cos(angleHip);

x2 = -Lll * cos(0.5*pi+angleHip - angleKnee);
y2 = Lll * sin(0.5*pi+angleHip - angleKnee);

x = x1 + x2;
y = y1 + y2;