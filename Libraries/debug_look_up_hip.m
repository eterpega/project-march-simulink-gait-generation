knee_spline = [1, 2, 3, 4];

lengthSpline = size(knee_spline,2);

angleKnee_spline_ext = zeros(lengthSpline,lengthSpline);

for i = 1:lengthSpline
    angleKnee_spline_ext(:, i) =  knee_spline(i);
end