clear all
close all
clc

[getFileName,PathName] = uigetfile('*.mat','Load gait theft data');
load(strcat(PathName, getFileName));


hip=S.hipPos;
back=S.backPos;

for n=1:length(hip(:,1))
    %define vectors
    lowerBack(n,:)=[back(n,1)-hip(n,1),back(n,2)-hip(n,2)];
    dotBack=lowerBack(n,1) * 0 + lowerBack(n,2) * 1;
    detBack=lowerBack(n,1) * 1 - lowerBack(n,2) * 0;
    backAngleRad(n,1)=-atan2(detBack,dotBack);
    backAngleDeg(n,1)=rad2deg(backAngleRad(n,1));
end

plot(backAngleDeg);