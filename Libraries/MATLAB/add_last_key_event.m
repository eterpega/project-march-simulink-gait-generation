function [keyEventNumber, keyEventPhase,keyEventy,keyEventdy] = add_last_key_event(keyEventNumber, keyEventPhase,keyEventy,keyEventdy)
%This function copies the first key event and places it at a 100% stride
%further.
keyEventNumber = keyEventNumber  + 1; %[-] new amount of key events

keyEventPhase(keyEventNumber) = keyEventPhase(1)+100; %[%]
keyEventy(keyEventNumber) = keyEventy(1);
keyEventdy(keyEventNumber) = keyEventdy(1);
end