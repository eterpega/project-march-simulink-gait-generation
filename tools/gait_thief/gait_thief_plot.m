%Plots data obtained by gait_thief
%Can be used to check it gait_thief data is consitent
%Due to the nature of the angle definition in gait_thief it might be
%necessary to multiply the data by -1 to obtain meaningfull joint angles
%Set this with the coeff variable

clear all
close all
clc

%%Set multiplication coefficient to 1 or -1
%Necessary when Flexion and Extension are inverted
coeff=-1; %-1

%%Get Video File
[getFileName,PathName] = uigetfile('*.mat','Load gait theft data');
load(strcat(PathName, getFileName));

%%Define start/stop frames
frameStart=1;
frameEnd=length(S.kneeAngleDeg(:,1));

%%Get right part
plotKnee=coeff*S.kneeAngleDeg(frameStart:frameEnd,:);
plotHip=coeff*S.hipAngleDeg(frameStart:frameEnd,:);
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
subplot(2,1,2);
hold on;
yLim=[-30 120];
for n=1:length(phase(:,1))
    line([phase(n),phase(n)],yLim,'Color','y','LineWidth',0.01);
end
plot(f1,phase,plotKnee);
title('Knee Angles');
ylim(yLim);
xlabel('Phase %');
ylabel('Angle (deg)');
hold off;

subplot(2,1,1);
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

Name=getFileName(1:end-4);
saveas(gcf,strcat(Name,'_JointAngles.fig'),'fig');