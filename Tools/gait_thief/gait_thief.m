clear all
close all
clc

%Read Video
[getFileName,PathName] = uigetfile('*.mov','Load video for gait theft')
v = VideoReader(strcat(PathName,getFileName));
%read first frame for size definition
vidFrame = readFrame(v);
%get size from frame
[H, W, B]=size(vidFrame);
%define start time of video
v.CurrentTime = 13;
%w = waitforbuttonpress;  %Returns 0 when terminated by a mouse
                        %buttonpress, or 1 when terminated
                        %by a keypress.
%set impoint contraint to size of image
fcn=makeConstrainToRectFcn('impoint',[0 W],[0 H]);

%set first data points (arbitrary)
data(1,:)=[W/2, H/1.5, W/2, H/2 W/2 H/3 W/2 H/4];
n=2;

while hasFrame(v)
    currAxes = axes;
    vidFrame = readFrame(v);
    startWidth=W/2;
    startHeight=H;
    image(vidFrame, 'Parent', currAxes);
    axis image;
    currAxes.Visible = 'off';
    h1=impoint(currAxes,data((n-1),1),data((n-1),2));
    h2=impoint(currAxes,data((n-1),3),data((n-1),4));
    h3=impoint(currAxes,data((n-1),5),data((n-1),6));
    setPositionConstraintFcn(h1,fcn);
    setPositionConstraintFcn(h2,fcn);
    setPositionConstraintFcn(h3,fcn);
    setString(h1,'A');
    setString(h2,'K');
    setString(h3,'H');
    setColor(h1,'w');
    setColor(h2,'w');
    setColor(h3,'w');
    pause
    hip=getPosition(h1);
    knee=getPosition(h2);
    ankle=getPosition(h3);
 data(n,:)=[hip(1,:), knee(1,:), ankle(1,:)]; 
 n=n+1;
end
data=data(2:end,:);
setFileName = uiputfile('gaittheft.mat','Save stolen gait data');
save(setFileName,data);