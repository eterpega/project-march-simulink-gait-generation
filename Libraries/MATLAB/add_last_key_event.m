function [keyEvent] = add_last_key_event(keyEvent)
%This function copies the first key event and places it at a 100% stride
%further.

%Determine the new amount of key events
keyEventNumber = size(keyEvent,2)+ 1; %[-]

%Copy the first colom of key events after the last colom
keyEvent(:,keyEventNumber) = keyEvent(:,1);

%Add 100% to the phase of the last key event
keyEvent(1,keyEventNumber) = keyEvent(1,keyEventNumber)+100;
end