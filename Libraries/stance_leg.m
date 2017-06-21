function [stanceLegRight, stanceLegLeft] = stance_leg(y)
%This function determines the stanceleg at every point in the gait
%A leg is a stance leg if the y position of that leg is higher than the y
%position of the other leg.

numberSamplePoints = length(y); %[-] Contains the amount of sample points.
halfPhase = 0.5*numberSamplePoints; %[-] this is the offset between the right and left leg.
yRightLeg = y; %[m] The y position of the right leg equals y
yLeftLeg = [y((halfPhase+1):numberSamplePoints); y(1:halfPhase)]; %[m] left leg is 50% out of phase

%% Determine stance leg
stanceLegRight = (yRightLeg > yLeftLeg); %[-] if high than is stance leg
stanceLegLeft = ~stanceLegRight; %[-] if high than is stance leg