clear all
close all
clc

t = 0:0.1:5;
numberDataPoints = 6;
xDataPoints = [0, 20, 40, 60, 80, 100];
yDataPoints = [0, 40, 30, -10,-10, 0];
dyDataPoints =[0, -1, -5,  0,  1, 0];
numberSamplePoins = 100;
xSamplePoints = [0:0.1:100]';

[ ySamplePoints, dydxSamplePoints, d2ydx2SamplePoints, d3ydx3SamplePoints ] = hermite_cubic_spline_value( numberDataPoints, xDataPoints, yDataPoints, dyDataPoints, numberSamplePoins, xSamplePoints );

figure('Position',[200,200,1000,400])
plot(xDataPoints,yDataPoints,'o','Color','b','MarkerFaceColor','b')
hold on
plot(xSamplePoints,ySamplePoints,'LineWidth',2) 
hold on

for i = 1:numberDataPoints
    plot(xDataPoints(i)+t,yDataPoints(i)+t*dyDataPoints(i),'Color','b','LineWidth',2)
    hold on
end
legend('Data Points','Interpolation Results','location','northeast')

title('Knee angle')
xlabel('Phase (%)')
ylabel('Angle (degree)')
grid on
axis([0,100,-20,50])
saveas(gcf,'HermiteAngles.png')

figure('Position',[200,0,800,900])
subplot(4,1,1)
plot(xSamplePoints,ySamplePoints,'LineWidth',2) 
ylabel('Angle [degree]')
xlabel('Stride Percentage [%]')
grid on

subplot(4,1,2)
plot(xSamplePoints,dydxSamplePoints,'LineWidth',2)
ylabel('Velocity [degree/%]')
xlabel('Stride Percentage [%]')
grid on

subplot(4,1,3)
plot(xSamplePoints,d2ydx2SamplePoints,'LineWidth',2)
ylabel('Acceleration [m/s^2]')
xlabel('Stride Percentage [%]')
grid on

subplot(4,1,4)
plot(xSamplePoints(1:(end-1)),diff(d2ydx2SamplePoints)/0.1,'LineWidth',2)
ylabel('Jerk [degree/%^3]')
xlabel('Stride Percentage [%]')
grid on
axis([0 100, -0.1, 0.05])
saveas(gcf,'HermitDerivatives.png')