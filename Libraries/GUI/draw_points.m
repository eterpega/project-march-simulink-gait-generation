function draw_points(hObject, eventdata, handles)
%guidata(hObject, handles);

%Define Graph type
switch hObject
    case handles.graphQKnee
        graphHandle=handles.graphQKnee;
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
        type='1';
    case handles.graphX
        graphHandle=handles.graphX;
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
        type='2';
    otherwise 
        error('ERROR: Inputtype not allowed')
end

%Clear figure of previous points
cla(graphHandle);
%Get data from values in GUI, assign to x and y
X=str2num(get(phaseHandle,'String'));
Y=str2num(get(yHandle,'String'));
dY=str2num(get(dYHandle,'String'));

%Check same that x and y have same length
if length(X)~=length(Y)
    error('Phase and Y vector do not have same length')
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',graphHandle.XLim,graphHandle.YLim);
        for n=1:length(X);
        h(n) = impoint(graphHandle,X(n),Y(n));
        setPositionConstraintFcn(h(n),fcn);
        %Write impoint handles and position to UserData field of Graph
        graphHandle.UserData.Points{n}=h(n);
        graphHandle.UserData.Position{n}=getPosition(h(n));
        guidata(hObject,handles);
        addNewPositionCallback(h(n),@(varargin)update_position_text(h(n),handles));
        position(n,:)=getPosition(h(n));
        end       

%Sort points on ascending X position
position = sortrows(position,1);
%Transpose position matrix
position = position';

%Update Handles
guidata(hObject,handles);

%Define name string of Simulink blocks to update
%TopLevelSyst='SplineGeneratorTest';
subsystemName1='KeyEventGeneratorRefMod';
subsystemName2='/Subsystem1';
completeBlockName=[subsystemName1 subsystemName2];
%CompleteBlockName=[ TopLevelSyst SubsystemName1 SubsystemName2];
phaseBlock=[completeBlockName '/keyEventPhase' type];
yBlock=[completeBlockName '/keyEventy' type];
dYBlock=[completeBlockName '/keyEventdY' type];
amountBlock=[completeBlockName '/keyEventAmount' type];
%strcmp('KeyEventGeneratorRefMod/Subsystem1/keyEventPhase1',PhaseBlock)

%Append NaN to reach dim of 20
phaseBlockString=nan_fill(position(1,:), 20);
yBlockString=nan_fill(position(2,:), 20);
dYBlockString=nan_fill(dY, 20);

%Write values in Simulink
set_param(phaseBlock,'Value',phaseBlockString);
set_param(phaseBlock,'Value',phaseBlockString);
set_param(yBlock,'Value',yBlockString);
set_param(dYBlock,'Value',dYBlockString);
set_param(amountBlock,'Value',num2str(length(position(1,:))));
set_param([completeBlockName '/selection'],'Value','[0 1 1 0]');
end


