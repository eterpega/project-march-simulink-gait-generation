clear all
close all
clc

%%Get Video File
[getFileName,PathName] = uigetfile('*.mat','Load gait theft data');
load(strcat(PathName, getFileName));

%%Define start/stop frames
frameStart=1;
frameEnd=length(S.kneeAngleDeg(:,1));

%%Get right part
plotKnee=S.kneeAngleDeg(frameStart:frameEnd,:);
plotHip=S.hipAngleDeg(frameStart:frameEnd,:);
dPhase=100/length(plotKnee(:,1));
phase(:,1)=0;
for n=2:length(plotKnee(:,1))
    phase(n,1)=phase(n-1,1)+dPhase;
end

smooth=0.995;    %smoothing parameter of the smoothpine interpolation...
                %has to be in between [0 1]
f1 = fit(phase,plotKnee,'smoothingspline','Normalize', 'on', 'SmoothingParam', smooth);
f2 = fit(phase,plotHip,'smoothingspline','Normalize', 'on','SmoothingParam', smooth);

figure;
hold on;

yLim=[-15 120];

for n=1:length(phase(:,1))
    line([phase(n),phase(n)],yLim,'Color','y','LineWidth',0.01);
end
plot(f1,phase,plotKnee);
title('Knee Angles');
ylim(yLim);
xlabel('Phase %');
ylabel('Angle (deg)');
hold off;

figure;
hold on;
for n=1:length(phase(:,1))
    line([phase(n),phase(n)],yLim,'Color','y','LineWidth',0.01);
end
plot(f2,phase,plotHip);
title('Hip Angles');
ylim(yLim);
xlabel('Phase %');
ylabel('Angle (deg)');
hold off