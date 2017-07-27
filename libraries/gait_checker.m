function gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength);

global LProximal angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum

errorDetected = 0;
warningDetected = 0;
message = 'None';

angleHip = hip.angleHip;
velocityHip = hip.dangleHip;
accelerationHip = hip.ddangleHip;

angleKnee = knee.angleKnee;
velocityKnee = knee.dangleKnee;
accelerationKnee = knee.ddangleKnee;

velocityHipMax = RPM_to_rads(24); 
velocityKneeMax = RPM_to_rads(24); 

y = y.y;

outOfRangeHip = out_of_range(angleHip, angleHipEndStopMinimum, angleHipEndStopMaximum);
outOfRangeKnee = out_of_range(angleKnee, angleKneeEndStopMinimum, angleKneeEndStopMaximum);

out_of_range_handler(outOfRangeHip, 'Hip angle becomes too low', 'Hip angle becomes too high');
out_of_range_handler(outOfRangeKnee, 'Knee angle becomes too low', 'Knee angle becomes too high');


%% Velocity check
if (max(abs(velocityHip) > velocityHipMax))
    warning('Velocity of hip is too high.');
end

if (max(abs(velocityKnee) > velocityKneeMax))
    warning('Velocity of knee is too high.');
end

%% y check

if sum(y > LProximal & angleHip > 0 & angleKnee > 0)
    warning('Your foor position is getting quite high, are you not overstrecthing?');
end