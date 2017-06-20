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
        type='1';
    case 'GraphX'
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        dYHandle=handles.KeyEventdYX;
        GraphHandle.XLim=handles.XXLim;
        GraphHandle.YLim=handles.XYLim;
        type='2';
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

%Define name string of Simulink blocks to update
SubsystemName='/Subsystem1';
PhaseBlock=[SubsystemName '/keyEventPhase' type];
YBlock=[SubsystemName '/keyEventy' type];
dYBlock=[SubsystemName '/keyEventdY' type];
AmountBlock=[SubsystemName '/keyEventAmount' type];

%Append NaN to reach dim of 20
%make function
PhaseBlockString=Nanfill(position(1,:), 20);
YBlockString=Nanfill(position(2,:), 20);
dYBlockString=Nanfill(dY, 20);

%Write values in Simulink
set_param([bdroot PhaseBlock],'Value',PhaseBlockString);
set_param([bdroot YBlock],'Value',YBlockString);
set_param([bdroot dYBlock],'Value',dYBlockString);
set_param([bdroot AmountBlock],'Value',num2str(length(position(1,:))));
set_param([bdroot SubsystemName '/selection'],'Value','[1 1 0 0]');

%Update Handles
guidata(graphhandle,handles);
end