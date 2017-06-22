clear all
clc

syms angleHip angleKnee
Lul = 0.4;
Lll = 0.4;

min_hip = -5 /360 * 2 * pi;
max_hip = 120 /360 * 2 * pi;

min_knee = -20 /360 * 2 * pi;
max_knee = 100 / 360 * 2 * pi;

N = 1000;

angleHip_table = linspace(min_hip, max_hip, N);

angleKnee_table = linspace(min_knee, max_knee, N);

x = zeros(N);
y = zeros(N);
tic
for i = 1:length(angleKnee_table)
    angleKnee =angleKnee_table(i);
    
    for j = 1:length( angleHip_table)
        angleHip = angleHip_table(j);
        
        x1 = Lul*sin(angleHip);
        y1 = Lul*cos(angleHip);

        x2 = Lll*cos(0.5*pi+angleHip - angleKnee);
        y2 = Lll*sin(0.5*pi+angleHip - angleKnee);
        
        x(i,j) = x1 - x2;
        y(i,j) = Lul + Lll - y2 - y1;
        
    end
end
%%
s.look_up_table_x = x;
s.look_up_table_y = y;
s.look_up_table_knee = angleKnee_table';
s.look_up_table_hip = angleHip_table';
save('look_up_table.mat','-struct', 's')

clear x y angleKnee_table angleHip_table
t_table = toc;

disp(['generation look up table took ', num2str(t_table), ' seconds'])
