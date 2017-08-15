%draws splines on graphs defined by the selected vectors

function [] = draw_splines(handles,gait,selected)

%assign struct values to vectors
splineHip=gait.splineHip;
splineKnee=gait.splineKnee;
splineX=gait.splineX;
splineY=gait.splineY;
spline1MinLimit=gait.spline1Limit.minimum;
spline1MaxLimit=gait.spline1Limit.maximum;
spline2MinLimit=gait.spline2Limit.minimum;
spline2MaxLimit=gait.spline2Limit.maximum;

%[hip, knee, x, y]
if selected==[1, 1, 0, 0]
    graphHandle1 = handles.graphQHip;
    graphHandle2 = handles.graphQKnee; 
    convFact1 = 180/pi;
    convFact2 = 180/pi;
elseif selected==[0, 0, 1, 1]
    graphHandle1 = handles.graphX;
    graphHandle2 = handles.graphY;
    convFact1 = 1;
    convFact2 = 1;    
elseif selected==[0, 1, 1, 0]
    graphHandle1 = handles.graphQKnee;
    graphHandle2 = handles.graphX;
    convFact1 = 180/pi;
    convFact2 = 1;    
else
    error('ERROR: parameter selection not valid for compute_splines')
end

%Convert to right units
spline1MinLimit=spline1MinLimit.*convFact1;
spline1MaxLimit=spline1MaxLimit.*convFact1;
spline2MinLimit=spline2MinLimit.*convFact2;
spline2MaxLimit=spline2MaxLimit.*convFact2;
       
delete_lines(handles.graphQHip);
delete_lines(handles.graphQKnee);
delete_lines(handles.graphX);
delete_lines(handles.graphY);
delete_lines(graphHandle1);
delete_lines(graphHandle2);

%Hold axes to not override points
hold(handles.graphQHip,'on');
hold(handles.graphQKnee,'on');
hold(handles.graphX,'on');
hold(handles.graphY,'on');

%plot splines
hipPlot=plot(handles.graphQHip, splineHip(:,1), splineHip(:,2),'b');
kneePlot=plot(handles.graphQKnee, splineKnee(:,1), splineKnee(:,2),'b');
xPlot=plot(handles.graphX, splineX(:,1), splineX(:,2),'b');
yPlot=plot(handles.graphY, splineY(:,1), splineY(:,2),'b');
limitPlot1Min=plot(graphHandle1, splineY(:,1), spline1MinLimit,'r');
limitPlot1Max=plot(graphHandle1, splineY(:,1), spline1MaxLimit,'r');
limitPlot2Min=plot(graphHandle2, splineY(:,1), spline2MinLimit,'r');
limitPlot2Max=plot(graphHandle2, splineY(:,1), spline2MaxLimit,'r');
drawnow

%Put spline at bottom of stack to the impoints can be dragged.
%Not doing so cause the points to be hidden behind the line and making it
%impossible to drag them
uistack(hipPlot,'bottom');
uistack(kneePlot,'bottom');
uistack(xPlot,'bottom');
uistack(yPlot,'bottom');
uistack(limitPlot1Min,'bottom');
uistack(limitPlot1Max,'bottom');
uistack(limitPlot2Min,'bottom');
uistack(limitPlot2Max,'bottom');

%Hold off all axes
hold(handles.graphQHip,'off');
hold(handles.graphQKnee,'off');
hold(handles.graphX,'off');
hold(handles.graphY,'off');

%update all handles
guidata(handles.graphQHip,handles);
guidata(handles.graphQKnee,handles);
guidata(handles.graphX,handles);
guidata(handles.graphY,handles);