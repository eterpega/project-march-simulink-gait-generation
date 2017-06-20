function UpdatePosText(h,handles)
graphhandle=get(h,'parent');

switch get(graphhandle,'Tag')
    case 'GraphQKnee'
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        dYHandle=handles.KeyEventdQKnee;
        GraphHandle.XLim=handles.KneeXLim;
        GraphHandle.YLim=handles.KneeYLim;
    case 'GraphX'
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        dYHandle=handles.KeyEventdYX;
        GraphHandle.XLim=handles.XXLim;
        GraphHandle.YLim=handles.XYLim;
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

%initialise strings
PhaseString='';
YString='';
dY=str2num(get(dYHandle,'String'));

%write coordinates to strings
for n=1:length(position(1,:))
    PhaseString=[PhaseString,num2str(position(1,n),'%2.1f'),', '];
    YString=[YString,num2str(position(2,n),'%2.1f'),', '];
end

%%String formatting
%Remove last comma
PhaseString=PhaseString(1:end-2);
YString=YString(1:end-2);
%Put brackets around
PhaseString=strcat('[',PhaseString,']');
YString=strcat('[',YString,']');
%Set property equal to string
set(PhaseHandle,'String',PhaseString);
set(YHandle,'String',YString);

%%Update values in Simulink (use position() because no rounding)
set_param([bdroot '/keyEventPhase'],'Value',strcat('[',num2str(position(1,:)),']'));
set_param([bdroot '/keyEventy'],'Value',strcat('[',num2str(position(2,:)),']'));
set_param([bdroot '/keyEventdY'],'Value',strcat('[',num2str(dY),']'));
set_param([bdroot '/keyEventAmount'],'Value',num2str(length(position(1,:))));

%Update Handles
guidata(graphhandle,handles);
end