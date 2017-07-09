function angleKnee = find_angle_knee(positionX,positionY)

global LProximal LDistal

%For deriavation see: https://confluence.projectmarch.nl:8443/pages/viewpage.action?pageId=9438020
angleKnee = acos((positionY.^2 + positionX.^2 - LProximal^2 - LDistal^2)/(2 .* LProximal.* LDistal)); %[m]