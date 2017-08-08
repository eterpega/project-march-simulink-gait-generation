function [stanceLegRight, stanceLegLeft] = stance_leg(y)
global gaitType

%This function determines the stanceleg at every point in the gait
%A leg is a stance leg if the y position of that leg is higher than the y
%position of the other leg.

numberSamplePoints = length(y); %[-] Contains the amount of sample points.
halfPhase = 0.5*numberSamplePoints; %[-] this is the offset between the right and left leg.
yRightLeg = y; %[m] The y position of the right leg equals y
yLeftLeg = [y((halfPhase+1):numberSamplePoints); y(1:halfPhase)]; %[m] left leg is 50% out of phase

%% Determine stance leg
if strcmpi(gaitType,'Continuous')
    stanceLegRight = (yRightLeg > yLeftLeg); %[-] if high than is stance leg
    stanceLegLeft = ~stanceLegRight; %[-] if high than is stance leg
elseif strcmpi(gaitType, 'Discontinuous')
    stanceLegRight = repmat(1,length(y),1);
    stanceLegLeft = repmat(0,length(y),1);
end