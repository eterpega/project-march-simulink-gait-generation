function [y] =  transform_to_ground(y,angleHip,angleKnee, stanceLegLeft)
Lul = 0.4;
Lll = 0.4;
lengthY = length(y);
phaseOffset = 0.5*lengthY;

phaseRight = 1:lengthY;
phaseLeft = mod(phaseRight+phaseOffset-1,lengthY)+1;

[~, yHip] = forwardKinematics(angleHip(phaseLeft),angleKnee(phaseLeft),Lul,Lll);
[~, yFoot]= forwardKinematics(angleHip(phaseRight),angleKnee(phaseRight),Lul,Lll);
y = stanceLegLeft .* (yHip - yFoot); %[m] If the stance leg right y should be zero
end