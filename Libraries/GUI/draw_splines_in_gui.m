function []=compute_splines(handles, selected, keyEvent1, keyEvent2)
%% First give an input which design spline has bee slected

%keyEvent1 = get_gait_data(handles,'knee');
%keyEvent2 = get_gait_data(handles,'x');

% Create phase vector. 
sampleFrequency = 1000; %[Hz] sample frequency of SLRT model
stepTime = 1.5; %[s] Time it takes for 1 step
strideTime = stepTime*2; %[s]
samplePointAmount = strideTime*sampleFrequency; %this will determine the speed
tInterval = strideTime/samplePointAmount; %[s] The difference in time between each interval

phase = linspace(0,99.9,samplePointAmount); %[%] Phase goes from 0 to 99.9... %
phaseToTime = strideTime/100;
time = phase*phaseToTime; %[s] Time vector

%% Move key events
% The first key event is copied and moved 100% further so a continious gait
% can be generated.
keyEvent1 = add_last_key_event(keyEvent1);
keyEvent2 = add_last_key_event(keyEvent2);

%% Check keyEvents
key_event_checker(keyEvent1, phaseToTime, 1, selected);
key_event_checker(keyEvent2, phaseToTime, 2, selected);

%% Calculate Gait
[hip, knee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength] = gait_calculator(keyEvent1, keyEvent2, selected, phase, tInterval);

%% Check gait
[errorDetected, warningDetected, message] = gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength);
if warningDetected
    warning(message);
end
if errorDetected
    error(message);
end

%% Process data

%angleHip
angleHip_deg = hip.angleHip/(pi)*180; %[deg]
%angleKnee
angleKnee_deg = knee.angleKnee/(pi)*180; %[deg]

%Make spline vectors [x y]
x.splineHip=[phase', angleHip_deg];
x.splineKnee=[phase', angleKnee_deg];
x.splineX=[phase', x.x];
x.splineY=[phase', y.y];

end