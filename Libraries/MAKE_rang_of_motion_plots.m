clear all
clc

load('look_up_table.mat')

%look up table is a matrix wich generated a matrix of N x N values for x
%and y. Where the rows represent different knee angles and the columns
%different hip angles. 

%so: i = knee angle , j = hip angle then the resulting x and y is
%look_up_table_x (i,j) and look_up_table_y (i,j)
%% plot range of motion for certain combination of parameters
N = length(look_up_table_knee);

for i = 1:N   
    %range of x w.r.t. knee angle
    knee_values(i) =  look_up_table_knee(i) * 360 / (2 *pi); %change to degrees
    knee_min_x(i)    = min(look_up_table_x(i,:));
    knee_max_x(i)    = max(look_up_table_x(i,:));
    
    knee_min_y(i) = min(look_up_table_y(i,:));
    knee_max_y(i) = max(look_up_table_y(i,:));
    
    %range of x w.r.t. hip angle angle
    hip_values(i) =  look_up_table_knee(i) * 360 / (2 *pi); %change to degrees
    hip_min_x(i)    = min(look_up_table_x(:,i));
    hip_max_x(i)    = max(look_up_table_x(:,i));
    
    hip_min_y(i) = min(look_up_table_y(:,i));
    hip_max_y(i) = max(look_up_table_y(:,i));
    
    
    
end

figure; 
subplot(1,2,1)
plot(knee_values, knee_min_x, 'b',  knee_values, knee_max_x, 'b')
xlabel('Knee angle [deg]')
ylabel('x [m]')
title('reachable area, x - Knee angle')
grid on

subplot(1,2,2)
plot(knee_values, knee_min_y, 'b',  knee_values, knee_max_y, 'b')
xlabel('Knee angle [deg]')
ylabel('y [m]')
title('reachable area, y - Knee angle')
grid on

figure; 
subplot(1,2,1)
plot(hip_values, hip_min_x, 'b',  hip_values, hip_max_x, 'b')
xlabel('Hip angle [deg]')
ylabel('x [m]')
title('reachable area, x - Hip angle')
grid on

subplot(1,2,2)
plot(hip_values, hip_min_y, 'b',  hip_values, hip_max_y, 'b')
xlabel('Hip angle [deg]')
ylabel('y [m]')
title('reachable area, y - Hip angle')
grid on
