function angleHip = findHipAngleAnalytical(angleKnee, x, y, Lul, Lll)
k1 = Lul + Lll * cos(angleKnee);
k2 = Lll * sin(angleKnee);
r = sqrt(k1.^2+k2.^2);
%angleHip = atan2(x,y) + atan2(k2,k1);
angleHip = atan2(x/r,-y/r + Lul + Lll) + atan2(k2,k1);
end

