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

%clear graph first
cla(graphHandle);

%Get data from values gaitData field of graph 'type' (see function input)
% and assign to x, y and dy
data=get_gait_data(handles,type);
X=data(1,:);
Y=data(2,:).*convFact;
dY=data(3,:).*convFact;

%Check same that x and y have same length
if length(X)~=length(Y) || length(X)~=length(dY) || length(Y)~=length(dY)
    msgbox('ERROR: Initializing Key Event input vectors do not have same length','Error: Initial Key Event input','warning')
    return
else
    %fcn=function handle of makeContriantToRectFcn)
    %Set draggable points on figure and limit their position within the axis
    %limits of the graph
    fcn=makeConstrainToRectFcn('impoint',graphHandle.XLim,graphHandle.YLim);
        for n=1:length(X)
        %create impoint and set at position x=X(n) y=Y(n)
        h(n) = impoint(graphHandle,X(n),Y(n));
        setPositionConstraintFcn(h(n),fcn);
        %Write impoint handles and position to UserData field of Graph
        graphHandle.UserData.Points{n}=h(n);
        %set position callback:
        %when position is changed the function update_position_text is
        %called
        addNewPositionCallback(h(n),@(varargin)update_position_text(h(n),handles));
        end   
end
        
%Update Handles
guidata(graphHandle,handles);
end


