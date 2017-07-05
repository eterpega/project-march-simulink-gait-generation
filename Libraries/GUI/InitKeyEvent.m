clear all
close all
clc

%%KeyEvent.mat initialization script

%Default values at startup [degrees, meters]
%knee [rad]
% data stored in matrix form: [phase; Y; dY]
knee.phase  =	[0, 18, 45, 78];
knee.y      =	[0, 15, 2, 60]*pi/180;
knee.dy     =	[0, -0.0035, -0.0035, 0]*pi/180;
%hip [rad]
hip.phase   =	[0, 18, 45, 78];
hip.y       =	[0, 15, 2, 60]*pi/180;
hip.dy      =	[0, -0.0035, -0.0035, 0]*pi/180;
%xFoot [meters]
x.phase     =   [0, 18, 45, 62];
x.y         =   [0.15, 0.0, -0.1, -0.25];
x.dy        =   [0, -0.0035, -0.0035, 0];
%yFoot [meters]
y.phase     =   [0, 18, 45, 62];
y.y         =   [0.15, 0.0, -0.1, -0.25];
y.dy        =   [0, -0.0035, -0.0035, 0];

selected=[0 1 1 0];
stepFreq=1.5;

%Save structs to file
filename='KeyEventData.mat';
save(filename,'hip');
save(filename,'knee','-append');
save(filename,'x','-append');
save(filename,'y','-append');
save(filename,'selected','-append');
save(filename,'stepFreq','-append');

clear all