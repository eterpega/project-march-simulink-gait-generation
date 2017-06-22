function key_event_checker(keyEvent, phaseToTime,keyEventNumber, selected)
% This function is used to check if none of the key events are out of 
%the limit of our joint

if keyEventNumber == 1
    selectedParameter = find(selected,1,'first');
elseif keyEventNumber == 2    
    selectedParameter = find(selected,1,'last'); 
end

if selectedParameter == 1
    %Hip angle
    valueMin = degree_to_rad(-20); %[rad]
    valueMax = degree_to_rad(110); %[rad]
    velocityMax = RPM_to_rads(2400);%[rad/s]
    accelerationMax = 99999;
elseif selectedParameter == 2
    %Knee angle
    valueMin = degree_to_rad(-5); %[rad]
    valueMax = degree_to_rad(110);%[rad]
     velocityMax = RPM_to_rads(2400);%[rad/s]
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

%keyEventAmount = size(keyEvent,2);
keyEventPhase = keyEvent(1,:);
position = keyEvent(2,:);
%keyEventdy = keyEvent(3,:);


velocity = diff(position)/(diff(keyEventPhase)*phaseToTime);


outOfRange = out_of_range(position, valueMin, valueMax);
out_of_range_handler(outOfRange, 'Key event to low', 'Key event too high');

outOfRange = out_of_range(velocity, -velocityMax, velocityMax);
out_of_range_handler(outOfRange,....
    'Velocity imposed by key event too high, move key events closer in y direction or further in x direction',...
    'Velocity imposed by key event too high, move key events closer in y direction or further in x direction');