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

set_gui_string(position(1,:),phaseHandle,'String','%2.1f');
set_gui_string(position(2,:),yHandle,'String','%2.1f');
dY=str2num(get(dYHandle,'String'));

% %Define name string of Simulink blocks to update
% %TopLevelSyst='/SplineGeneratorTest';
% subsystemName1='KeyEventGeneratorRefMod';
% subsystemName2='/Subsystem1';
% completeBlockName=[subsystemName1 subsystemName2];
% phaseBlock=[completeBlockName '/keyEventPhase' type];
% yBlock=[completeBlockName '/keyEventy' type];
% dYBlock=[completeBlockName '/keyEventdY' type];
% amountBlock=[completeBlockName '/keyEventAmount' type];
% 
% %Append NaN to reach dim of 20
% phaseBlockString=nan_fill(position(1,:), 20);
% yBlockString=nan_fill(position(2,:), 20);
% dYBlockString=nan_fill(dY, 20);
% 
% %Write values in Simulink
% set_param(phaseBlock,'Value',phaseBlockString);
% set_param(phaseBlock,'Value',phaseBlockString);
% set_param(yBlock,'Value',yBlockString);
% set_param(dYBlock,'Value',dYBlockString);
% set_param(amountBlock,'Value',num2str(length(position(1,:))));
% set_param([completeBlockName '/selection'],'Value','[0 1 1 0]');

%Update Handles
guidata(graphHandle,handles);
end