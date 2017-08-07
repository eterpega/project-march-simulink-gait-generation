function animation_gui(handles, selected)
% Does preparations for running animate_gait.m

dynamic = 0; %if set to one the animation will walk away

% First give an input which design spline has bee slected
%[hip, knee, x, y]
if selected==[1, 1, 0, 0]
    keyEvent1 = get_gait_data(handles,'hip');
    keyEvent2 = get_gait_data(handles,'knee');    
elseif selected==[0, 0, 1, 1]
    keyEvent1 = get_gait_data(handles,'x');
    keyEvent2 = get_gait_data(handles,'y'); 
elseif selected==[0, 1, 1, 0]
    keyEvent1 = get_gait_data(handles,'knee');
    keyEvent2 = get_gait_data(handles,'x'); 
else
    error('ERROR: parameter selection not valid for animation_gui')
end

% Create phase vector. 
global sampleFrequency stepTime
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
[hip, knee, x, y, foot, stanceLegRight, stanceLegLeft, stepLength] = gait_calculator(keyEvent1, keyEvent2, selected, phase, tInterval);

%% Check gait
gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft, stepLength);

%% Animate 
%Find positions to plot
[xRight, yRight, xLeft, yLeft] = position_leg(x.x , y.y, hip.angleHip,...
    knee.angleKnee, stanceLegRight, stanceLegLeft);

%Lock the x of the stance leg foot
[xRight, xLeft] = lock_x_stance_leg(xRight, xLeft, stanceLegRight, ...
    stanceLegLeft, dynamic);

%Animate position leg
animate_gait(xRight,yRight,xLeft,yLeft,sampleFrequency, ...
    samplePointAmount,stepLength, dynamic)