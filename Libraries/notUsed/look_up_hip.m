function [angleHip] = look_up_hip(knee_spline, x_spline, table_hip, table_knee, table_x, table_y)
%This looks up y and hip angle based on knee angle and x

% first we extend the knee angle array to a matrix of N x spline_points
% where N is the size of the look up table

%easier
knee_spline = knee_spline';
x_spline = x_spline';

lengthTable = length(table_y(1,:)); %Length look up table
lengthSpline = size(knee_spline,2); %Length knee spline

angleKnee_spline_ext = zeros(lengthTable, lengthSpline);

for i = 1:lengthSpline
    angleKnee_spline_ext(:, i) =  knee_spline(i);
end

%with this extended spline data (all the rows in a column just have the
%same value, this is needed to find the minimum in a row w.r.t. to this
%spline point.
%find row index in look up table which is closest to given knee angle

difference = zeros(length(table_knee));

for i = 1:lengthSpline
    difference(:,i) = abs(table_knee - angleKnee_spline_ext(:,i));
end
[~, row_index] = min(difference,[],2);

%for every row find the column at which the x spline value is closest
x_spline_ext = zeros(lengthTable, lengthSpline);


column_index = nan(1,1000);
difference = nan(1,1000);

for i = 1:lengthSpline
    difference = table_x(row_index(i),:)'- x_spline(i);
    [xError, column_index(i)] = min(abs(difference));
end
    
%  for i = 1:lengthSpline
%      x_spline_ext(i,:) = x_spline(i);
%  end
% 
%  
%  
% difference = abs(table_x(row_index,:)' - x_spline_ext);
% [~, column_index] = min(difference,[] , 2);

%now for every (knee_angle,x) we have a (row,column) number thus we can
%look up the corresponding hip and y angles as follows:

angleHip = table_hip(column_index);
end