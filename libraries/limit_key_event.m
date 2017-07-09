function [spline1Limit, spline2Limit] = limit_key_event(spline1, spline2, selected)


% determine which key events are selected
if selected(1) && selected(2) %angle knee and angle hip given
    
    angleHip = spline1; %[rad]
    angleKnee = spline2; %[rad]
    
    [spline1Limit.minimum, spline1Limit.maximum]  = limit_angle_hip_knee(angleKnee);
    [spline2Limit.minimum, spline2Limit.maximum]  = limit_angle_knee_hip(angleHip);
    
elseif selected(2) && selected(3) %angle knee and x given
    
    angleKnee = spline1; %[rad]
    positionX = spline2; %[m]
        
    [spline1Limit.minimum, spline1Limit.maximum] = limit_angle_knee_position_x(positionX);   
    [spline2Limit.minimum, spline2Limit.maximum]= limit_position_x_angle_knee(angleKnee);


elseif selected(3) && selected(4) %position x and position y given    

    positionY = spline1; %[rad]
    positionX = spline2; %[m]
    
    [spline1Limit.minimum, spline1Limit.maximum] = limit_position_y_position_x(positionX);   
    [spline2Limit.minimum, spline2Limit.maximum] = limit_position_x_position_y(positionY);
    
else
    %This still has to be finished
    warning('please select other design parameters, these are not working (yet).')
    positionY = nan(1000,1);
    positionX = nan(1000,1);
    angleHip =nan(1000,1);
    angleKnee =nan(1000,1);  
end