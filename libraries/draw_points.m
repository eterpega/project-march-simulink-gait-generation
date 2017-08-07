function [position] = draw_points(type, eventdata, handles)

%Define Graph type
switch type
    case 'knee'
        graphHandle=handles.graphQKnee;
        phaseHandle=handles.keyEventPhaseKnee;
        yHandle=handles.keyEventQKnee;
        dYHandle=handles.keyEventdQKnee;
        convFact=(180/pi);
    case 'hip'
        graphHandle=handles.graphQHip;
        phaseHandle=handles.keyEventPhaseHip;
        yHandle=handles.keyEventQHip;
        dYHandle=handles.keyEventdQHip;
        convFact=(180/pi);
    case 'x'
        graphHandle=handles.graphX;
        phaseHandle=handles.keyEventPhaseX;
        yHandle=handles.keyEventX;
        dYHandle=handles.keyEventdYX;
        convFact=1;
    case 'y'  
        graphHandle=handles.graphY;
        phaseHandle=handles.keyEventPhaseY;
        yHandle=handles.keyEventY;
        dYHandle=handles.keyEventdYY;
        convFact=1;
    otherwise 
        msgbox('ERROR: Key Event input vectors do not have same length','Error: User input Key Event')
        return
end

%Delete all previous impoints
delete_impoints(graphHandle);

%Get data from values in GUI, assign to x and y
data=get_gait_data(handles,type);
X=data(1,:);
Y=data(2,:).*convFact;
dY=data(3,:).*convFact;

%Check same that x and y have same length
if length(X)~=length(Y) || length(X)~=length(dY) || length(Y)~=length(dY)
    msgbox('ERROR: Initializing Key Event input vectors do not have same length','Initial Key Event input error')
    return
else
    %Set draggable points on figure and limit them to axis of figure
    fcn=makeConstrainToRectFcn('impoint',graphHandle.XLim,graphHandle.YLim);
        for n=1:length(X)
        graphHandle.UserData.Points{n} = impoint(graphHandle,X(n),Y(n));
        setPositionConstraintFcn(graphHandle.UserData.Points{n},fcn);
        %Write impoint handles and position to UserData field of Graph
        addNewPositionCallback(graphHandle.UserData.Points{n},@(varargin)update_position_text(graphHandle.UserData.Points{n},handles));
        end  
end

%Update Handles
guidata(graphHandle,handles);
end


