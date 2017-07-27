function angleHip = find_hip_angle(angleKnee, x, y)

global LProximal LDistal

%For equations see: https://confluence.projectmarch.nl:8443/pages/viewpage.action?pageId=9438023
k1 = LProximal + LDistal * cos(angleKnee); %[m]
k2 = LDistal * sin(angleKnee); %[m]
angleHip = atan2(x,y) + atan2(k2,k1); %[rad] Angle of hip
end

