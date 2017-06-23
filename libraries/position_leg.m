function [xRight, yRight, xLeft, yLeft] = position_leg(x, y, angleHip, angleKnee, stanceLegRight, stanceLegLeft, Lul, Lll)
samplePointAmount = length(angleHip);
phase = 1:samplePointAmount;

samplePointAmount = length(phase);
phaseRight(1,:) = phase;
phaseLeft(1,:) = mod(phase+0.5*samplePointAmount-1,samplePointAmount)+1;

xFootLeft(1,:) = x(phaseLeft);
yFootLeft(1,:) = y(phaseLeft);   
xFootRight(1,:) = x(phaseRight);
yFootRight(1,:) = y(phaseRight);   

[~, yHipRight(1,:)] = forwardKinematics(angleHip(phaseRight),angleKnee(phaseRight),Lul,Lll);
[~, yHipLeft(1,:)] = forwardKinematics(angleHip(phaseLeft),angleKnee(phaseLeft),Lul,Lll);


yHip(1,:) = stanceLegRight' .* yHipRight + stanceLegLeft' .* yHipLeft; 
xHip(1,:) = zeros(1,samplePointAmount)';  

xKneeRight(1,:) = xHip' + 0.4*sin(angleHip(phaseRight));
yKneeRight(1,:) = yHip' -0.4*cos(angleHip(phaseRight));
xKneeLeft(1,:) = xHip' + 0.4*sin(angleHip(phaseLeft));
yKneeLeft(1,:) = yHip' -0.4*cos(angleHip(phaseLeft));

xRight = [xFootRight; xKneeRight; xHip];
yRight = [yFootRight; yKneeRight; yHip];

xLeft = [xFootLeft; xKneeLeft; xHip];
yLeft = [yFootLeft; yKneeLeft; yHip];
%legLengthRightUL = determine_length(xKneeRight, yKneeRight, xHip, yHip);
%legLengthLeftLL = determine_length(xKneeLeft, yKneeLeft, xHip, yHip);
%legLengthRightUL = determine_length(xFootRight, yFootRight, xKneeRight, yKneeRight);
%legLengthLeftLL = determine_length(xFootLeft, yFootLeft, xKneeLeft, yKneeLeft);
