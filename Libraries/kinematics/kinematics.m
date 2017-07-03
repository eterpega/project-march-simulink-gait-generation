function [x, y, angleKnee, angleHip] = kinematics(design_spline_data_1,...
    design_spline_data_2, selected)

%variable selected says wfor which variables the spline was made [hip knee x y]
%if ...  == 1 this variable was chosen
if selected(1) && selected(2) %angle knee and angle hip given
    
    angleHip = design_spline_data_1; %[rad]
    angleKnee = design_spline_data_2; %[rad]
    
    %we can find the x and y with forward kinematics
    [x,y] = forward_kinematics(angleHip,angleKnee); %[m]
    
elseif selected(2) && selected(3) %angle knee and x given
    
    angleKnee = design_spline_data_1; %[rad]
    x = design_spline_data_2; %[m]
    
    y = find_y(angleKnee, x); %[m]
    angleHip = find_hip_angle(angleKnee, x, y); %[rad]
    
else
    %This still has to be finished
    warning('please select other design parameters, these are not working (yet).')
    valuesAmount = length(design_spline_data_1);
    y = nan(valuesAmount,1);
    x = nan(valuesAmount,1);
    angleHip =nan(valuesAmount,1);
    angleKnee =nan(valuesAmount,1);   
end