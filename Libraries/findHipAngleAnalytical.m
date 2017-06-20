function angleHip = findHipAngleAnalytical(angleKnee, x, y, Lul, Lll)
k1 = Lul + Lll * cos(angleKnee);
k2 = Lll * sin(angleKnee);

angleHip = atan2(x,y) + atan2(k2,k1);
end

