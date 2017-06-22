close all
clear all
clc


axis([0,4*pi,-1,1])

x = linspace(0,4*pi,1000);
y = sin(x);

plot(x,y)

figure
h = animatedline;
for k = 1:length(x)
    addpoints(h,x(k),y(k));
    drawnow
end