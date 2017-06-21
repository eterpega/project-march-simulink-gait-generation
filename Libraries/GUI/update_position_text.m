function update_position_text(h,handles)
graphHandle=get(h,'parent');

switch get(graphHandle,'Tag')
    case 'graphQKnee'
        graphHandle=handles.graphQKnee;
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
        type='1';
    case 'graphX'
        graphHandle=handles.graphX;
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
        type='2';
    otherwise 
        error('ERROR: Inputtype not allowed')
end

%Get point positions
for n=1:size(graphHandle.UserData.Points,2)
    impoints=graphHandle.UserData.Points{n};
    position(n,:)=getPosition(impoints);
end

%Sort points on ascending X position
position = sortrows(position,1);
%Transpose position matrix
position = position';

format='%2.2f';
set_gui_string(position(1,:),phaseHandle,'String',format);
set_gui_string(position(2,:),yHandle,'String',format);
dY=str2num(get(dYHandle,'String'));
%[phaseEvent1, phaseEvent2, selected] = get_gait_data(handles)

%Update Handles
guidata(graphHandle,handles);
end