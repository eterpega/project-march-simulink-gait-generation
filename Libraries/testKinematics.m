close all
clear all
clc

%% This matalb script is written to test the kinematic function
Lul = 0.4; %[m] Length upper leg (no not of something else)
Lll = 0.4; %[m] Length lower leg

angleHip = linspace(-10,110,1000)/180*pi; %[rad]
angleKnee = linspace(-5,115,1000)/180*pi; %[rad]

[x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll);

%yTest = findY(angleKnee, x,Lul,Lll);
%angleHipTest = findHipAngleAnalytical(angleKnee, x, y, Lul, Lll);

k1 = Lul + Lll * cos(angleKnee);
k2 = Lll * sin(angleKnee);

xTest1 = k1 .* sin(angleHip) - k2 .* cos(angleHip);
yTest1 = - k1 .* cos(angleHip) - k2 .* sin(angleHip)+Lul + Lll;

r = sqrt(k1.^2 + k2.^2);
gamma = atan2(k2,k1);

xTest2 = r .* cos(gamma) .* sin(angleHip) - r .* sin(gamma) .* cos(angleHip);
yTest2 = r .* cos(gamma) .* cos(angleHip) + r .* sin(gamma) .* sin(angleHip);

angleHipTest = findHipAngleAnalytical(angleKnee, x, y, Lul, Lll);
figure

figure
plot(y,'LineWidth',5)
hold on
plot(yTest1,'LineWidth',4)
hold on
plot(yTest2,'LineWidth',3)
title('y')
legend('Should be','Result1','Result2')
grid on

figure
plot(x,'LineWidth',3)
hold on
plot(xTest1)
hold on
plot(xTest2)
title('x')
legend('Should be','Result1','Result2')
grid on

figure
plot(angleHip,'LineWidth',2)
hold on
plot(angleHipTest)
legend('Should be','Result')
title('hipAngle')
grid on