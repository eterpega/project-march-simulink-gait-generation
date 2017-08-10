function [gait, phase, angleHip_deg,angleKnee_deg, x, y,...
    angleHip_RPM, angleKnee_RPM, angleHip_rads2, angleKnee_rads2, time,...
    samplePointAmount, warningCount, messageWarning]=compute_splines(handles, selected)
%% First give an input which design spline has bee slected
%[hip, knee, x, y]

%define the right key events to get based on the selection list. The
%conversion factor is used to rightly convert from rad to deg as the data
if selected==[1, 1, 0, 0]
    keyEvent1 = get_gait_data(handles,'hip');
    keyEvent2 = get_gait_data(handles,'knee');
    convFact1 = 180/pi;
    convFact2 = 180/pi;
elseif selected==[0, 0, 1, 1]
    keyEvent1 = get_gait_data(handles,'x');
    keyEvent2 = get_gait_data(handles,'y'); 
    convFact1 = 1;
    convFact2 = 1;
elseif selected==[0, 1, 1, 0]
    keyEvent1 = get_gait_data(handles,'knee');
    keyEvent2 = get_gait_data(handles,'x'); 
    convFact1 = 180/pi;
    convFact2 = 1;
else
    error('ERROR: parameter selection not valid for compute_splines')
end

%% Move key events
% The first key event is copied and moved 100% further so a continious gait
% can be generated.
global gaitType sampleFrequency stepTime stepLength stepVel
if strcmpi(gaitType,'Continuous')
    keyEvent1 = add_last_key_event(keyEvent1);
    keyEvent2 = add_last_key_event(keyEvent2);
    strideTime = stepTime*2 %[s]
elseif strcmpi(gaitType, 'Discontinuous')
    strideTime = stepTime %[s]
else
    msgbox('ERROR: Gait type selection is invalid','Error in compute_splines')
end

% Create phase vector.
sampleFrequency
samplePointAmount = strideTime*sampleFrequency %this will determine the speed
tInterval = strideTime/samplePointAmount; %[s] The difference in time between each interval

phase = linspace(0,99.9,samplePointAmount); %[%] Phase goes from 0 to 99.9... %
phaseToTime = strideTime/100;
time = phase*phaseToTime; %[s] Time vector


%% Check keyEvents
key_event_checker(keyEvent1, phaseToTime, 1, selected);
key_event_checker(keyEvent2, phaseToTime, 2, selected);

%% Calculate Gait
[hip, knee, x, y, foot, stanceLegRight, stanceLegLeft, stepLength, spline1Limit, spline2Limit] = gait_calculator(keyEvent1, keyEvent2, selected, phase, tInterval);

%% Check gait
gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft, stepLength);

[warningCount, messageWarning] = gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft, stepLength);

%Gait parameters for GUI
stepVel=stepLength/stepTime;
set(handles.stepLength,'String',num2str(stepLength));
set(handles.stepVel,'String',num2str(stepVel));

%% Process data

%angleHip
angleHip_deg = hip.angleHip/(pi)*180; %[deg]
angleHip_RPM = hip.dangleHip/(2*pi)*60; %[RPM]
angleHip_rads2 = hip.ddangleHip; %[rad/s^2]

%angleKnee
angleKnee_deg = knee.angleKnee/(pi)*180; %[deg]
angleKnee_RPM = knee.dangleKnee/(2*pi)*60; %[RPM]
angleKnee_rads2 = knee.ddangleKnee; %[rad/s^2]

%Make spline vectors [x y]
gait.splineHip=[phase', angleHip_deg];
gait.splineKnee=[phase', angleKnee_deg];
gait.splineX=[phase', x.x];
gait.splineY=[phase', y.y];
gait.spline1Limit=spline1Limit;
gait.spline2Limit=spline2Limit;

draw_splines(handles,gait,selected)
end