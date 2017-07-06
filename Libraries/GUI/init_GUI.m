function init_GUI(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%% Define global parameters
global LProximal LDistal angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum sampleFrequency stepTime

% leg length
LProximal = 0.4; %[m]
LDistal = 0.4; %[m]

sampleFrequency = 1000; %[Hz] sample frequency of SLRT model

%Load keyEventData from .mat file at startup [rad, meters]
filename='KeyEventData.mat';
keyEventData  =	load(filename);
%knee [rad]
knee=keyEventData.knee;
%hip [rad]
hip=keyEventData.hip;
%xFoot [meters]
x=keyEventData.x;
%yFoot [meters]
y=keyEventData.y;
%Selected vector
selected=keyEventData.selected;
%Step frequency
stepTime=keyEventData.stepTime; %[s] Time it takes for 1 step

% end stops
angleKneeEndStopMinimum = deg2rad(-5);
angleKneeEndStopMaximum = deg2rad(110);
angleHipEndStopMinimum = deg2rad(-10);
angleHipEndStopMaximum = deg2rad(115);

%Define graph limit values GUI
kneeXLim=[0 100 ];
kneeYLim=[(rad2deg(angleKneeEndStopMinimum)-5) (rad2deg(angleKneeEndStopMaximum)+5)];
hipXLim=[0 100];
hipYLim=[(rad2deg(angleHipEndStopMinimum)-5) (rad2deg(angleHipEndStopMaximum)+5)];
xXLim=[0 100];
xYLim=[-0.4 0.4];
yXLim=[0 100];
yYLim=[0 0.2];

%Clear all plots
cla(handles.graphQHip);
cla(handles.graphQKnee);
cla(handles.graphX);
cla(handles.graphY);

%Set Graph Axis limits
set(handles.graphQKnee,'XLim',kneeXLim);
set(handles.graphQKnee,'YLim',kneeYLim);
set(handles.graphQHip,'XLim',hipXLim);
set(handles.graphQHip,'YLim',hipYLim);
set(handles.graphX,'XLim',xXLim);
set(handles.graphX,'YLim',xYLim);
set(handles.graphY,'XLim',yXLim);
set(handles.graphY,'YLim',yYLim);

%Set stepTime
set(handles.stepTime,'String',num2str(stepTime));

%Write data to UserData field of respective graph
setappdata(handles.graphQKnee,'gaitData',knee);
setappdata(handles.graphQHip,'gaitData',hip);
setappdata(handles.graphX,'gaitData',x);
setappdata(handles.graphY,'gaitData',y);

%Write converted init values to GUI
format='%2.2f';
dyformat='%2.4f';
%Knee
set_gui_string(handles.graphQKnee,'phase',handles.keyEventPhaseKnee,'String', format, 1);
set_gui_string(handles.graphQKnee,'y',handles.keyEventQKnee,'String', format, 180/pi);
set_gui_string(handles.graphQKnee,'dy',handles.keyEventdQKnee,'String', dyformat, 180/pi);
%Hip
set_gui_string(handles.graphQHip,'phase',handles.keyEventPhaseHip,'String', format, 1);
set_gui_string(handles.graphQHip,'y',handles.keyEventQHip,'String', format, 180/pi);
set_gui_string(handles.graphQHip,'dy',handles.keyEventdQHip,'String', dyformat, 180/pi);
%X
set_gui_string(handles.graphX,'phase',handles.keyEventPhaseX,'String', format, 1);
set_gui_string(handles.graphX,'y',handles.keyEventX,'String', format, 1);
set_gui_string(handles.graphX,'dy',handles.keyEventdYX,'String',dyformat, 1);
%Y
set_gui_string(handles.graphY,'phase',handles.keyEventPhaseY,'String', format, 1);
set_gui_string(handles.graphY,'y',handles.keyEventY,'String', format, 1);
set_gui_string(handles.graphY,'dy',handles.keyEventdYY,'String',dyformat, 1);

%Determine selected parameters from selection list in GUI
%selected=param_selection(handles);
setappdata(handles.SelectionList,'selected',selected);
[selected,type1,type2] = param_selection(handles);

%Draw Graphs at initialization
%DrawPoints(hObject, eventdata, handles);
init_points(type1, eventdata, handles);
init_points(type2, eventdata, handles);

%Draw the splines in the GUI
compute_splines(handles,selected);

% Update handles structure
guidata(hObject, handles);
end
