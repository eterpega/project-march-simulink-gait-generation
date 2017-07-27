clear all
close all
clc

%Read Video
[getFileName,PathName] = uigetfile('*.mov','Load video for gait theft');
v = VideoReader(strcat(PathName,getFileName));
%read first frame for size definition
vidFrame = readFrame(v);
%get size from frame
[H, W, B]=size(vidFrame);
%define start time of video
v.CurrentTime = 0;
endTime=100;
%set impoint contraint to size of image
fcn=makeConstrainToRectFcn('impoint',[0 W],[0 H]);
startTime=v.CurrentTime;
%set first data points (arbitrary)
data(1,:)=[W/2, H/1.5, W/2, H/2, W/2, H/3, W/2, H/4];
n=2;
currAxes = axes;
while hasFrame(v) && v.CurrentTime<endTime
    currFrame=round((v.CurrentTime-startTime)*v.FrameRate)
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    axis image;
    currAxes.Visible = 'off';
    h1=impoint(currAxes,data((n-1),1),data((n-1),2));
    h2=impoint(currAxes,data((n-1),3),data((n-1),4));
    h3=impoint(currAxes,data((n-1),5),data((n-1),6));
    h4=impoint(currAxes,data((n-1),7),data((n-1),8));
    setPositionConstraintFcn(h1,fcn);
    setPositionConstraintFcn(h2,fcn);
    setPositionConstraintFcn(h3,fcn);
    setPositionConstraintFcn(h4,fcn);
    setString(h1,'A');
    setString(h2,'K');
    setString(h3,'H');
    setString(h4,'B');
    setColor(h1,'w');
    setColor(h2,'w');
    setColor(h3,'w');
    setColor(h4,'w');
    pause
    ankle=getPosition(h1);
    knee=getPosition(h2);
    hip=getPosition(h3);
    back=getPosition(h4);
    delete(h1);
    delete(h2);
    delete(h3);
    delete(h4);
    data(n,:)=[ankle(1,:), knee(1,:), hip(1,:), back(1,:)]; 
    n=n+1;
end
data=data(2:end,:);

%convert data to origin in left lower corner
data(:,2)=abs(data(:,2)-H);
data(:,4)=abs(data(:,4)-H);
data(:,6)=abs(data(:,6)-H);
data(:,8)=abs(data(:,8)-H);
anklePos(:,1:2)=    data(:,1:2);
kneePos(:,1:2)=     data(:,3:4);
hipPos(:,1:2) =     data(:,5:6);
backPos(:,1:2)=     data(:,7:8);

%Process data
[hipAngleRad, kneeAngleRad, hipAngleDeg, kneeAngleDeg, ...
    lowerBack, upperLeg, lowerLeg] = process_gait_theft(data);

S.lowerBack=lowerBack;
S.upperLeg=upperLeg;
S.lowerLeg=lowerLeg;
S.hipAngleRad=hipAngleRad;
S.kneeAngleRad=kneeAngleRad;
S.hipAngleDeg=hipAngleDeg;
S.kneeAngleDeg=kneeAngleDeg;
S.anklePos=anklePos;
S.kneePos=kneePos;
S.hipPos=hipPos;
S.backPos=backPos;

%save file
cd(PathName);
Name=getFileName(1:end-4);
mkdir(Name);
cd(strcat('.',filesep,Name));
save(strcat(Name),'S');

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
for n=1:length(phase(:,1))
    line([phase(n),phase(n)],[-5 120],'Color','y','LineWidth',0.01);
end
plot(f1,phase,plotKnee);
title('Knee Angles');
ylim([-5 120]);
xlabel('Phase %');
ylabel('Angle (deg)');
hold off;

saveas(gcf,strcat(Name,'_KneeAngles.fig'),'fig');

figure;
hold on;
for n=1:length(phase(:,1))
    line([phase(n),phase(n)],[-5 120],'Color','y','LineWidth',0.01);
end
plot(f2,phase,plotHip);
title('Hip Angles');
ylim([-5 120]);
xlabel('Phase %');
ylabel('Angle (deg)');
hold off

saveas(gcf,strcat(Name,'_HipAngles.fig'),'fig');