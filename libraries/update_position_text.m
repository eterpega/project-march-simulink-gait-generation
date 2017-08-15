%This function is called when an impoints position changes by dragging
%It updates the position text in the text field left of the graph and
%stores this data in the gaitData field of the respective graph object

function update_position_text(h,handles)
%Find handle of parent graph of impoint that is dragged
graphHandle=get(h,'parent');

%determine the handles of the text fields to edit based on the parent graph handle
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

%Find Children if the graph
childHandle=get(graphHandle,'children');
%find handles of all impoints on that graph
%(looks for objects that are not lines)
impointHandles = findobj(childHandle,'-depth',1,'-not','Type','Line');

%Get points position from impoints on graph
for n=1:size(impointHandles,1)
    position(n,:)=getPosition(graphHandle.UserData.Points{n});
end

%Read dy data (this cannot be retrieved from the impoints position so it 
%has to be read from the gaitData field
dy=getappdata(graphHandle,'gaitData');
position(:,3)=dy.dy;

%Sort points on ascending X position
position = sortrows(position,1);

%Transpose matrix
position = position';

%Create gaitData struct with position data
data.phase = position(1,:);
data.y = position(2,:).*convFact;
data.dy = position(3,:);

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