function DrawPoints(hObject, eventdata, handles)
%guidata(hObject, handles);

%Define Graph type
switch hObject
    case handles.GraphQKnee
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        dYHandle=handles.KeyEventdQKnee;
        type='1';
    case handles.GraphX
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        dYHandle=handles.KeyEventdYX;
        type='2';
    otherwise 
        error('ERROR: Inputtype not allowed')
end

%Clear figure of previous points
cla(GraphHandle);
%Get data from values in GUI, assign to x and y
X=str2num(get(PhaseHandle,'String'));
Y=str2num(get(YHandle,'String'));
dY=str2num(get(dYHandle,'String'));

%Check same that x and y have same length
if length(X)~=length(Y)
    error('Phase and Y vector do not have same length')
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',GraphHandle.XLim,GraphHandle.YLim);
        for n=1:length(X);
        h(n) = impoint(GraphHandle,X(n),Y(n));
        setPositionConstraintFcn(h(n),fcn);
        %Write impoint handles and position to UserData field of Graph
        GraphHandle.UserData.Points{n}=h(n);
        GraphHandle.UserData.Position{n}=getPosition(h(n));
        guidata(hObject,handles);
        addNewPositionCallback(h(n),@(varargin)UpdatePosText(h(n),handles));
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
SubsystemName1='/KeyEventGeneratorRefMod';
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
end


