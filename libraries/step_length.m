function stepLenth = step_length(x, stanceLegRight)
%The step length can be found by determining how mhuch the stance leg moves
%backward.

%First determine when the right leg is the stance leg
location = find(stanceLegRight); %data points whem right leg is stance leg.
startStance = min(location); %The first momnet the right leg becomes the stance leg.
endStance = max(location); %The moment the right leg becomes the swing leg.

%Thans the step length can be find be susbstarcing the x position and the
%end of the stance phase from the x position at the beginning of the stance
%phase.
stepLenth = x(startStance) - x(endStance); %[m] Step length