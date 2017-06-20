function DrawPoints(hObject, eventdata, handles)
guidata(hObject, handles);

%Define Graph type
switch hObject
    case handles.GraphQKnee
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        dYHandle=handles.KeyEventdQKnee;
        GraphHandle.XLim=handles.KneeXLim;
        GraphHandle.YLim=handles.KneeYLim;
    case handles.GraphX
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        dYHandle=handles.KeyEventdYX;
        GraphHandle.XLim=handles.XXLim;
        GraphHandle.YLim=handles.XYLim;
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

%Write values in Simulink
set_param([bdroot '/keyEventPhase'],'Value',strcat('[',num2str(position(1,:)),']'));
set_param([bdroot '/keyEventy'],'Value',strcat('[',num2str(position(2,:)),']'));
set_param([bdroot '/keyEventdY'],'Value',strcat('[',num2str(dY),']'));
set_param([bdroot '/keyEventAmount'],'Value',num2str(length(position(1,:))));
%set_param([bdroot '/selection'],'Value',num2str());
%set_param([bdroot '/nSP'],'Value',num2str(position(1,:)));
end


