function [keyEventNumber, keyEventPhase,keyEventy,keyEventdy] = add_last_key_event(keyEventNumber, keyEventPhase,keyEventy,keyEventdy)
%This function copies the first key event and places it at a 100%phase
%further

keyEventPhase(keyEventNumber+1) = keyEventPhase(1)+100;
keyEventy(keyEventNumber+1) = keyEventy(1);
keyEventdy(keyEventNumber+1) = keyEventdy(1);
keyEventNumber = keyEventNumber  + 1;
%phase = linspace(keyEventPhase(1),keyEventPhase(1)+100,1001)';
end