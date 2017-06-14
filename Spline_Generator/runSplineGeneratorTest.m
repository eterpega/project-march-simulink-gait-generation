clc
close all
clear all

sim('SplineGeneratorTest.slx') 

angles1 = f1.Data(1,:);
%angles2 = f2.Data(1,:);
plot(angles1)
%hold on
%plot(angles2)