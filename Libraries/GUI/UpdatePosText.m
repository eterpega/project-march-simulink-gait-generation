function UpdatePosText(h,handles)
pos = getPosition(h);
graph=get(h,'parent');

switch get(graph,'Tag')
    case 'GraphQKnee'
        GraphHandle=handles.GraphQKnee;
        PhaseHandle=handles.KeyEventPhaseKnee;
        YHandle=handles.KeyEventQKnee;
        GraphHandle.XLim=handles.KneeXLim;
        GraphHandle.YLim=handles.KneeYLim;
    case 'GraphX'
        GraphHandle=handles.GraphX;
        PhaseHandle=handles.KeyEventPhaseX;
        YHandle=handles.KeyEventX;
        GraphHandle.XLim=handles.XXLim;
        GraphHandle.YLim=handles.XYLim;
    otherwise 
        error('ERROR: Inputtype not allowed')
end
for n=1:size(GraphHandle.UserData.Points,2)
    hother=GraphHandle.UserData.Points{n};
    position(n,:)=getPosition(hother);
end

%Sort points on ascending X position
position = sortrows(position,1);
%Transpose position matrix
position = position';

%initialise strings
PhaseString='';
YString='';

%write coordinates to strings
for n=1:length(position(1,:))
    PhaseString=[PhaseString,num2str(position(1,n),'%2.1f'),', '];
    YString=[YString,num2str(position(2,n),'%2.1f'),', '];
end

%Remove last comma
PhaseString=PhaseString(1:end-2);
YString=YString(1:end-2);

%Put brackets around
PhaseString=strcat('[',PhaseString,']');
YString=strcat('[',YString,']');

%Set property equal to string
set(PhaseHandle,'String',PhaseString);
set(YHandle,'String',YString);

%Update Handles
guidata(graph,handles);
end