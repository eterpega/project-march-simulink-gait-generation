function [x, y, angleKnee, angleHip] = kinematics(design_spline_data_1,...
    design_spline_data_2, selected)

Lul = 0.4; %[m] Length upper leg (no not of something else)
Lll = 0.4; %[m] Length lower leg

%variable selected says wfor which variables the spline was made [ hip knee x y]
%if ...  == 1 this variable was chosen
if selected(1) && selected(2) %angle knee and angle hip given
    
    angleHip = design_spline_data_1;
    angleKnee = design_spline_data_2;
    
    [x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll);
    
elseif selected(2) && selected(3) %angle knee and x given
    
    angleKnee = design_spline_data_1;
    x = design_spline_data_2;
    
    %[angleHip] = look_up_hip(angleKnee, x, table_hip_in, table_knee_in, table_x_in, table_y_in);
    y = findY(angleKnee, x,Lul,Lll);
    angleHip = findHipAngle(angleKnee, x, y, Lul, Lll);
    
else
    x = nan(1000,1);
    angleHip =nan(1000,1);
    angleKnee =nan(1000,1);
    y = nan(1000,1);
    
end