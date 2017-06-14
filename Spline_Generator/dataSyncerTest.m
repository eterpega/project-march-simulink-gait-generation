close all
clc

offSet = 20;

plotPhase = 0:0.1:100;
y = plotPhase.^2/100;

figure
plot(plotPhase)
hold on
plot(y)

[plotPhase, sortIndex] = sort(plotPhase);
y = y(sortIndex);

figure
plot(plotPhase)
hold on
plot(y)