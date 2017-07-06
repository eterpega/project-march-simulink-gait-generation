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

if any(isgraphics(get(handles.graphQHip ,'children'),'Line'))
       any(isgraphics(get(handles.graphQKnee,'children'),'Line'))||...
       any(isgraphics(get(handles.graphX,'children'),'Line'))||...
       any(isgraphics(get(handles.graphY,'children'),'Line'));
    
    %Find children handles of axes
    childrenHip = get(handles.graphQHip, 'children');
    childrenKnee = get(handles.graphQKnee, 'children');
    childrenX = get(handles.graphX, 'children');
    childrenY = get(handles.graphY, 'children');
    childrenLimit1 = get(graphHandle1, 'children');
    childrenLimit2 = get(graphHandle2, 'children');
    
    %Find handles of splines
    lineHandleHip=findobj(childrenHip,'-depth',1,'Type','Line');
    lineHandleKnee=findobj(childrenKnee,'-depth',1,'Type','Line');
    lineHandleX=findobj(childrenX,'-depth',1,'Type','Line');
    lineHandleY=findobj(childrenY,'-depth',1,'Type','Line');
    lineHandleLimit1=findobj(childrenLimit1,'-depth',1,'Type','Line');
    lineHandleLimit2=findobj(childrenLimit2,'-depth',1,'Type','Line');
        
    %Delete previous lines    
    delete(lineHandleHip(1));
    delete(lineHandleKnee(1));
    delete(lineHandleX(1));
    delete(lineHandleY(1));
    delete(lineHandleLimit1(1:3));
    delete(lineHandleLimit2(1:3));
    
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
    
    %Put spline at bottom of stack
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
    
else
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
    
    %Put spline at bottom of stack
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

end

%update all handles
guidata(handles.graphQHip,handles);
guidata(handles.graphQKnee,handles);
guidata(handles.graphX,handles);
guidata(handles.graphY,handles);