function angleHipFinal = findHip(angleKnee, x, Lul, Lll)
lengthx = length(x);
angleHipFinal = nan(lengthx,1);
for i = 1:lengthx
    angleHip = asin(x(i)/(Lul+Lll)); %this would be the case if the kneeAngle = 0;
    error = 1;
        while error > 0.0001
            hipPrev = angleHip;
            angleHip = asin(Lll/Lul*cos(0.5*pi+angleHip-angleKnee(i)) + x(i)/Lul);
            error = hipPrev - angleHip;
        end
    angleHipFinal(i) = angleHip;
end

