function UpdatePosText(h,handles)
graphhandle=get(h,'parent');

switch get(graphhandle,'Tag')
    case 'GraphQKnee'
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        dYHandle=handles.KeyEventdQKnee;
        type='1';
    case 'GraphX'
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        dYHandle=handles.KeyEventdYX;
        type='2';
    otherwise 
        error('ERROR: Inputtype not allowed')
end

%Get point positions
for n=1:size(GraphHandle.UserData.Points,2)
    impoints=GraphHandle.UserData.Points{n};
    position(n,:)=getPosition(impoints);
end

%Sort points on ascending X position
position = sortrows(position,1);
%Transpose position matrix
position = position';

setguistring(position(1,:),PhaseHandle,'String','%2.1f');
setguistring(position(2,:),YHandle,'String','%2.1f');
dY=str2num(get(dYHandle,'String'));

%Define name string of Simulink blocks to update
%TopLevelSyst='/SplineGeneratorTest';
SubsystemName1='KeyEventGeneratorRefMod';
SubsystemName2='/Subsystem1';
CompleteBlockName=[SubsystemName1 SubsystemName2];
PhaseBlock=[CompleteBlockName '/keyEventPhase' type];
YBlock=[CompleteBlockName '/keyEventy' type];
dYBlock=[CompleteBlockName '/keyEventdY' type];
AmountBlock=[CompleteBlockName '/keyEventAmount' type];

%Append NaN to reach dim of 20
PhaseBlockString=Nanfill(position(1,:), 20);
YBlockString=Nanfill(position(2,:), 20);
dYBlockString=Nanfill(dY, 20);

%Write values in Simulink
set_param(PhaseBlock,'Value',PhaseBlockString);
set_param(PhaseBlock,'Value',PhaseBlockString);
set_param(YBlock,'Value',YBlockString);
set_param(dYBlock,'Value',dYBlockString);
set_param(AmountBlock,'Value',num2str(length(position(1,:))));
set_param([CompleteBlockName '/selection'],'Value','[0 1 1 0]');

%Update Handles
guidata(graphhandle,handles);
end