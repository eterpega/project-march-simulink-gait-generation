close all
clear all
clc

%% This matalb script is written to test the kinematic function
Lul = 0.4; %[m] Length upper leg (no not of something else)
Lll = 0.4; %[m] Length lower leg

angleHip = linspace(-10,110,1000)/180*pi; %[rad]
angleKnee = linspace(-5,115,1000)/180*pi; %[rad]

[x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll);

yTest = findY(angleKnee, x,Lul,Lll);
angleHipTest1 = findHipAngleAnalytical(angleKnee, x, y, Lul, Lll);

k1 = Lul + Lll * cos(angleKnee);
k2 = Lll * sin(angleKnee);

xTest1 = k1 .* sin(angleHip) - k2 .* cos(angleHip);
yTest1 = k1 .* cos(angleHip) + k2 .* sin(angleHip);

r = sqrt(k1.^2 + k2.^2);
gamma = atan2(k2,k1);

xTest2 = r .* cos(gamma) .* sin(angleHip) - r .* sin(gamma) .* cos(angleHip);
yTest2 = r .* cos(gamma) .* cos(angleHip) + r .* sin(gamma) .* sin(angleHip);

xTest3 = r .* sin(angleHip - gamma);
yTest3 = r .* cos(angleHip - gamma);

angleHipTest2 = atan2(xTest3,yTest3)+atan2(k2,k1);

figure
plot(y,'LineWidth',15)
hold on
plot(yTest1,'LineWidth',10)
hold on
plot(yTest2,'LineWidth',7)
hold on
plot(yTest3,'LineWidth',2)
title('y')
legend('Should be','Result1','Result2','3')
grid on

figure
plot(x,'LineWidth',15)
hold on
plot(xTest1,'LineWidth',10)
hold on
plot(xTest2,'LineWidth',7)
hold on
plot(xTest3,'LineWidth',2)
title('x')
legend('Should be','Result1','Result2','3')
grid on

figure
plot(angleHip,'LineWidth',15)
hold on
plot(angleHipTest1,'LineWidth',10)
hold on
plot(angleHipTest2,'LineWidth',7)
legend('Should be','Result1','Result2')
title('hipAngle')
grid on