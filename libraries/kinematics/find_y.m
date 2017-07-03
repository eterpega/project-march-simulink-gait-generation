function y = find_y(angleKnee, x)

global LProximal LDistal

%For deriavation see: https://confluence.projectmarch.nl:8443/pages/viewpage.action?pageId=9438020
y = sqrt(LProximal^2 + LDistal^2+2 .* LProximal.* LDistal .*cos(angleKnee)-x.^2); %[m]
end

