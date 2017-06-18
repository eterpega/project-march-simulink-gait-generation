function [angleHip, y] = look_up_hip_y(knee_spline, x_spline, table_hip, table_knee, table_x, table_y)
%This looks up y and hip angle based on knee angle and x

% first we extend the knee angle array to a matrix of N x spline_points
% where N is the size of the look up table

%easier
knee_spline = knee_spline';
x_spline = x_spline';

angleKnee_spline_ext = zeros(length(table_y(1,:)), size(knee_spline,2));

for i = 1:length(knee_spline)
    angleKnee_spline_ext(:, i) =  knee_spline(i);
end

%with this extended spline data (all the rows in a column just have the
%same value, this is needed to find the minimum in a row w.r.t. to this
%spline point.
%find row index in look up table which is closest to given knee angle
differences = zeros(length(table_knee));
for i = 1:length(table_knee)
    differences(:,i) = abs(table_knee - angleKnee_spline_ext(:,i));
end
[~, row_index] = min(differences,[],2);
 

%for every row find the column at which the x spline value is closest
x_spline_ext = zeros(size(angleKnee_spline_ext));

 for i = 1:length(x_spline)
     x_spline_ext(i,:) = x_spline(i);
 end
 
[~, column_index] = min(abs(table_x(row_index, :)' - x_spline_ext),[] , 2);

%now for every (knee_angle,x) we have a (row,column) number thus we can
%look up the corresponding hip and y angles as follows:

angleHip = table_hip(column_index);
y = zeros(length(row_index),1);

for i = 1:length(row_index)
    y(i) = table_y(row_index(i), column_index(i));
end
end