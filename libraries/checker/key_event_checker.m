function key_event_checker(keyEvent, phaseToTime,keyEventNumber, selected)
% This function is used to check if none of the key events are out of 
%the limit of our joint
global angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum velocityMaximumHip ...
    velocityMaximumKnee

if keyEventNumber == 1
    selectedParameter = find(selected,1,'first');
elseif keyEventNumber == 2    
    selectedParameter = find(selected,1,'last'); 
end

if selectedParameter == 1
    %Hip angle
    valueMin = angleHipEndStopMinimum; %[rad]
    valueMax = angleHipEndStopMaximum; %[rad]
    velocityMax = velocityMaximumHip;%[rad/s]
elseif selectedParameter == 2
    %Knee angle
    valueMin = angleKneeEndStopMinimum; %[rad]
    valueMax = angleKneeEndStopMaximum;%[rad]
     velocityMax = velocityMaximumKnee;%[rad/s]
elseif selectedParameter == 3
    %x position
    valueMin = -0.8; %[m]
    valueMax = 0.8;  %[m]
    velocityMax = 10;%[m/s]
elseif selectedParameter == 4
    %hip pangle
    valueMin = -0.8; %[m]
    valueMax = 0.8;  %[m] 
    velocityMax = 10;%[m/s]
end

keyEventPhase = keyEvent(1,:);
position = keyEvent(2,:);
velocity = diff(position)./(diff(keyEventPhase*phaseToTime));

outOfRange = out_of_range(position, valueMin, valueMax);
out_of_range_handler(outOfRange, 'Key event too low', 'Key event too high');

outOfRange = out_of_range(velocity, -velocityMax, velocityMax);
out_of_range_handler(outOfRange,....
    'Velocity imposed by key event too high, move key events closer in y direction or further in x direction',...
    'Velocity imposed by key event too high, move key events closer in y direction or further in x direction');