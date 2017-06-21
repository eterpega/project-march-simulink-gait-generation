function [x, y, angleKnee, angleHip] = kinematics(design_spline_data_1,...
    design_spline_data_2, selected)

% First we define the legnths of the leg parts, this obviously should be 
% done somewhere else!
Lul = 0.4; %[m] Length upper leg (no not of something else...)
Lll = 0.4; %[m] Length lower leg

%variable selected says wfor which variables the spline was made [hip knee x y]
%if ...  == 1 this variable was chosen
if selected(1) && selected(2) %angle knee and angle hip given
    
    angleHip = design_spline_data_1; %[rad]
    angleKnee = design_spline_data_2; %[rad]
    
    %we can find the x and y with forward kinematics
    [x,y] = forwardKinematics(angleHip,angleKnee,Lul,Lll); %[m]
    
elseif selected(2) && selected(3) %angle knee and x given
    
    angleKnee = design_spline_data_1; %[rad]
    x = design_spline_data_2; %[m]
    
    y = findY(angleKnee, x,Lul,Lll); %[m]
    angleHip = findHipAngle(angleKnee, x, y, Lul, Lll); %[rad]
    
else
    %This still has to be finished
    warning('please select other design parameters, these are not working (yet).')
    y = nan(1000,1);
    x = nan(1000,1);
    angleHip =nan(1000,1);
    angleKnee =nan(1000,1);   
end