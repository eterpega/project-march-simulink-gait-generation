function DrawPoints(hObject, eventdata, handles)
guidata(hObject, handles);

%Define Graph type
switch hObject
    case handles.GraphQKnee
        type=1;
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        GraphHandle.XLim=handles.KneeXLim;
        GraphHandle.YLim=handles.KneeYLim;
    case handles.GraphX
        type=2;
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
%Get data from values in GUI, assign to x and y
x=str2num(get(PhaseHandle,'String'));
y=str2num(get(YHandle,'String'));
%PhaseHandle=num2str(x);
%YHandle=num2str(y);


%Check same that x and y have same length
if length(x)~=length(y)
    error('Phase and Y vector do not have same length')
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',GraphHandle.XLim,GraphHandle.YLim);
        for n=1:length(x);
        h(n) = impoint(GraphHandle,x(n),y(n));
        setPositionConstraintFcn(h(n),fcn);
        GraphHandle.UserData.Points{n}=h(n);
        GraphHandle.UserData.Position{n}=getPosition(h(n));
        guidata(hObject,handles);
        addNewPositionCallback(h(n),@(varargin)UpdatePosText(h(n),handles));
        end       
for n=1:size(GraphHandle.UserData.Points,2)
    hother=GraphHandle.UserData.Points{n};
    position(n,:)=getPosition(hother);
end

%Sort points on ascending X position
position = sortrows(position,1);
%Transpose position matrix
position = position'

guidata(hObject,handles);
%get_param([bdroot '/keyEventPhase'],'ObjectParameters')
%get_param([bdroot '/keyEventPhase'],'Name')
set_param([bdroot '/keyEventPhase'],'Value',strcat('[',num2str(position(1,:)),']'));
set_param([bdroot '/keyEventy'],'Value',strcat('[',num2str(position(2,:)),']'));
set_param([bdroot '/keyEventdy'],'Value',strcat('[',num2str(position(2,:)),']'));
set_param([bdroot '/keyEventAmount'],'Value',num2str(length(position(1,:))));
%set_param([bdroot '/selection'],'Value',num2str());
%set_param([bdroot '/nSP'],'Value',num2str(position(1,:)));
end


