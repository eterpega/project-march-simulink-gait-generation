function update_position_text(h,handles)

%Find graphHandle
graphHandle=get(h,'parent');

switch get(graphHandle,'Tag')
    case 'graphQKnee'
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
        convFact=(pi/180);
    case 'graphQHip'
        phaseHandle=handles.keyEventPhaseHip;
        yHandle=handles.keyEventQHip;
        dYHandle=handles.keyEventdQHip;
        convFact=(pi/180);
    case 'graphX'
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
        convFact=1;
    case 'graphY'
        phaseHandle=handles.keyEventPhaseY;
        yHandle=handles.keyEventY;
        dYHandle=handles.keyEventdYY;
        convFact=1;
    otherwise 
        msgbox('Error: Inputtype not allowed','Error: update_position_text')
end

%Find Children
childHandle=get(graphHandle,'children');
impointHandles = findobj(childHandle,'-depth',1,'-not','Type','Line');

%Get points position from graph
for n=1:size(impointHandles,1)
    position(n,:)=getPosition(graphHandle.UserData.Points{n});
end

%Read dy data
dy=getappdata(graphHandle,'gaitData');
position(:,3)=dy.dy;

%Sort points on ascending X position
position = sortrows(position,1);

%Transpose matrix
position = position';

%Create data struct with position data
data.phase = position(1,:);
data.y = position(2,:).*convFact;
data.dy = position(3,:).*convFact;

%Set gaitData field to data
setappdata(graphHandle,'gaitData',data);

%Write gait data to respective GUI text fields
format='%2.2f';
dyformat='%2.4f';
set_gui_string(graphHandle,'phase',phaseHandle,'String', format, 1);
set_gui_string(graphHandle,'y',yHandle,'String', format, 1/convFact);
set_gui_string(graphHandle,'dy',dYHandle,'String', dyformat, 1/convFact);

guidata(graphHandle,handles);

%Draw splines on graph
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

%Update Handles
guidata(graphHandle,handles);


end