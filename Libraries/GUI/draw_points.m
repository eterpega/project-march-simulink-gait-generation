function [position] = draw_points(hObject, eventdata, handles)
guidata(hObject, handles);

%Define Graph type
switch hObject
    case handles.graphQKnee
        graphHandle=handles.graphQKnee;
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
    case handles.graphX
        graphHandle=handles.graphX;
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
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
%graphHandle.UserData.Position=position;

%Update Handles
guidata(hObject,handles);
end


