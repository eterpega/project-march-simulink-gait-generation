clc
close all
clear all

sim('SplineGeneratorTest.slx') 

angles1 = f1.Data(1,:);
angles2 = f2.Data(1,:);
figure
plot(0:0.1:99.9,angles1,'o')
hold on
plot(100:0.1:199.9,angles1,'o')
hold on
plot(0:0.1:99.9,angles2,'o')
hold on
plot(100:0.1:199.9,angles2,'o')