%gets the gaitData data from the graph defined by the string 'type'

function [phaseEvent] = get_gait_data(handles,type)

if strcmpi(type,'knee')
    data=getappdata(handles.graphQKnee,'gaitData');
    phase=data.phase;
    y=data.y;
    dy=data.dy;
    guidata(handles.graphQKnee,handles);
elseif strcmpi(type,'hip')
    data=getappdata(handles.graphQHip,'gaitData');
    phase=data.phase;
    y=data.y;
    dy=data.dy;
    guidata(handles.graphQHip,handles);
elseif strcmpi(type,'x')
    data=getappdata(handles.graphX,'gaitData');
    phase=data.phase;
    y=data.y;
    dy=data.dy;
    guidata(handles.graphX,handles);
elseif strcmpi(type,'y')
    data=getappdata(handles.graphY,'gaitData');
    phase=data.phase;
    y=data.y;
    dy=data.dy;
    guidata(handles.graphY,handles);
else
    error('ERROR: get_gait_data type is NOT valid')
end

if length(phase)~=length(y) || length(phase)~=length(dy) || length(y)~=length(dy)
     %msgbox(strcat('ERROR: Key Event input vectors of [',type,'] do not have same length'),'Key Event input error','warn','replace')
     return
end
     
phaseEvent=[phase; y; dy];

