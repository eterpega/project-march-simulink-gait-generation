function angleHip = findHipAngle(angleKnee, x, y, Lul, Lll)
%For equations see: https://confluence.projectmarch.nl:8443/pages/viewpage.action?pageId=9438023
k1 = Lul + Lll * cos(angleKnee); %[m]
k2 = Lll * sin(angleKnee); %[m]
angleHip = atan2(x,y) + atan2(k2,k1); %[rad] Angle of hip
end

