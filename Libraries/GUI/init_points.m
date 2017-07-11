function [position] = init_points(type, eventdata, handles)

%Define Graph type
switch type
    case 'knee'
        graphHandle=handles.graphQKnee;
        convFact=(180/pi);
    case 'hip'
        graphHandle=handles.graphQHip;
        convFact=(180/pi);
    case 'x'
        graphHandle=handles.graphX;
        convFact=1;
    case 'y'  
        graphHandle=handles.graphY;
        convFact=1;
    otherwise 
        msgbox('ERROR: Input type not allowed','Error: init_points','error')
end
cla(graphHandle)
%Get data from values in GUI, assign to x and y
data=get_gait_data(handles,type);
X=data(1,:);
Y=data(2,:).*convFact;
dY=data(3,:).*convFact;

%Check same that x and y have same length
if length(X)~=length(Y) || length(X)~=length(dY) || length(Y)~=length(dY)
    msgbox('ERROR: Initializing Key Event input vectors do not have same length','Error: Initial Key Event input','warning')
    return
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',graphHandle.XLim,graphHandle.YLim);
        for n=1:length(X)
        h(n) = impoint(graphHandle,X(n),Y(n));
        setPositionConstraintFcn(h(n),fcn);
        %Write impoint handles and position to UserData field of Graph
        graphHandle.UserData.Points{n}=h(n);
        addNewPositionCallback(h(n),@(varargin)update_position_text(h(n),handles));
        end   
end
        
%Update Handles
guidata(graphHandle,handles);
end


