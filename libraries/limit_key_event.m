function [spline1Limit, spline2Limit] = limit_key_event(spline1, spline2, selected)

if selected(1) && selected(2) %angle knee and angle hip given

    angleHip = spline1; %[rad]
    angleKnee = spline2; %[rad]
    
    [angleHipMinimum, angleHipMaximum]  = limit_angle_hip_knee(angleKnee);
    [angleKneeMinimum, angleKneeMaximum]  = limit_angle_knee_hip(angleHip);
    
    spline1Limit = [angleHipMinimum; angleHipMaximum];
    spline2Limit = [angleKneeMinimum; angleKneeMaximum];  
    
elseif selected(2) && selected(3) %angle knee and x given
    
    angleKnee = spline1; %[rad]
    x = spline2; %[m]
    
    [angleKneeMinimum, angleKneeMaximum] = limit_angle_knee_position_x(x);
    [positionXMinimum, positionXMaximum]= limit_position_x_angle_knee(angleKnee);
    
    spline1Limit = [angleKneeMinimum; angleKneeMaximum];
    spline2Limit = [positionXMinimum; positionXMaximum];
else
    %This still has to be finished
    warning('please select other design parameters, these are not working (yet).')
    y = nan(1000,1);
    x = nan(1000,1);
    angleHip =nan(1000,1);
    angleKnee =nan(1000,1);  
end