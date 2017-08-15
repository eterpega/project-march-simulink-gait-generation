%Update the gaitData field of the graph object defined by the string 'type'

function []=update_gait_data(type, handles);

%define the handles based on the input string 'type'
if strcmpi(type,'hip')
        graphHandle=handles.graphQHip;
        phaseHandle=handles.keyEventPhaseHip;
        yHandle=handles.keyEventQHip;
        dYHandle=handles.keyEventdQHip;
        convFact=(pi/180);
elseif strcmpi(type,'knee')
        graphHandle=handles.graphQKnee;
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
        convFact=(pi/180);
elseif strcmpi(type,'x')
        graphHandle=handles.graphX;
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
        convFact=1;
elseif strcmpi(type,'y')
        graphHandle=handles.graphY;
        phaseHandle=handles.keyEventPhaseY;
        yHandle=handles.keyEventY;
        dYHandle=handles.keyEventdYY;
        convFact=1;
else 
        error('ERROR: Input type not allowed')
end

%get data from text field
phase=str2num(get(phaseHandle,'String'));
y=str2num(get(yHandle,'String'));
dy=str2num(get(dYHandle,'String'));

%Check input values are within phase range
if max(phase)>100 || min(phase)<0
    msgbox(strcat('ERROR: Phase of [',type,'] has to be in range [0:100]'),'Error: Key Event input','error')
    return
end

%find max and minimum values of Y data
maxY=max(get(graphHandle,'YLim'));
minY=min(get(graphHandle,'YLim'));

%Check input values are within Y range
if max(y)>maxY || min(y)<minY
    msgbox(strcat('ERROR: Y value of [',type,'] has to be in range [',num2str(minY),':',num2str(maxY),']'),'Error: Key Event input','error')
    return
end

%Construct struct
x.phase=phase;
x.y=y.*convFact;
x.dy=dy.*convFact;

%Update gaitData field
setappdata(graphHandle,'gaitData',x);

%Update handles
guidata(graphHandle,handles);