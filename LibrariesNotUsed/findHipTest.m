Lul = 0.4;
Lll = 0.4;

x= linspace(0.2, -0.2,1000);
angleKnee =linspace(0.1,60,1000)/180*pi;


lengthx = length(x);
angleHipFinal = nan(lengthx,1);
tic
for i = 1:lengthx
    angleHip = asin(x(i)/(Lul+Lll)); %this would be the case if the kneeAngle = 0;
    error = 1;
        while error > 0.00001
            hipPrev = angleHip;
            angleHip = asin(Lll/Lul*cos(0.5*pi+angleHip-angleKnee(i)) + x(i)/Lul);
            error = hipPrev - angleHip;
        end
    angleHipFinal(i) = angleHip;
end
toc