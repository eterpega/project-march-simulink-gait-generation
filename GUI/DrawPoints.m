function DrawPoints(hObject, eventdata, handles)

%Define Graph type
switch hObject
    case handles.GraphQKnee
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        GraphHandle.XLim=handles.KneeXLim;
        GraphHandle.YLim=handles.KneeYLim;
    case handles.GraphX
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        GraphHandle.XLim=handles.XXLim;
        GraphHandle.YLim=handles.XYLim;
    otherwise 
        error('ERROR: Inputtype not allowed')
end

%Clear figure of previous points
cla(GraphHandle);

%Get data from values entered in GUI, assign to x and y
x=str2num(get(PhaseHandle,'String'));
y=str2num(get(YHandle,'String'));

%Check same that x and y have same length
if length(x)~=length(y)
    error('Phase and Y vector do not have same length')
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',GraphHandle.XLim,GraphHandle.YLim);
        for n=1:length(x);
        h = impoint(GraphHandle,x(n),y(n));
        set(h, 'Tag', strcat('h',num2str(n)));
        setPositionConstraintFcn(h,fcn);
        addNewPositionCallback(h,@(varargin)UpdatePosText(h));
        end
end
guidata(hObject, handles);


