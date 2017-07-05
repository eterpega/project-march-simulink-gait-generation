function [] = draw_splines(handles,gait)

%assign struct values to vectors
splineHip=gait.splineHip;
splineKnee=gait.splineKnee;
splineX=gait.splineX;
splineY=gait.splineY;

if any(isgraphics(get(handles.graphQHip ,'children'),'Line'))
       any(isgraphics(get(handles.graphQKnee,'children'),'Line'))||...
       any(isgraphics(get(handles.graphX,'children'),'Line'))||...
       any(isgraphics(get(handles.graphY,'children'),'Line'));
    
    %Find children handles of axes
    childrenHip = get(handles.graphQHip, 'children');
    childrenKnee = get(handles.graphQKnee, 'children');
    childrenX = get(handles.graphX, 'children');
    childrenY = get(handles.graphY, 'children');
    
    %Find handles of splines
    lineHandleHip=findobj(childrenHip,'-depth',1,'Type','Line');
    lineHandleKnee=findobj(childrenKnee,'-depth',1,'Type','Line');
    lineHandleX=findobj(childrenX,'-depth',1,'Type','Line');
    lineHandleY=findobj(childrenY,'-depth',1,'Type','Line');
    
    %Delete previous lines    
    delete(lineHandleHip(1));
    delete(lineHandleKnee(1));
    delete(lineHandleX(1));
    delete(lineHandleY(1));
    
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
    drawnow
    
    %Put spline at bottom of stack
    uistack(hipPlot,'bottom');
    uistack(kneePlot,'bottom');
    uistack(xPlot,'bottom');
    uistack(yPlot,'bottom');
    
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
    drawnow
    
    %Put spline at bottom of stack
    uistack(hipPlot,'bottom');
    uistack(kneePlot,'bottom');
    uistack(xPlot,'bottom');
    uistack(yPlot,'bottom');
    
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