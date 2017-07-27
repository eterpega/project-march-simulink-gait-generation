function [warningCount, messageWarning] = gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength);

global LProximal angleKneeEndStopMinimum angleKneeEndStopMaximum ...
    angleHipEndStopMinimum angleHipEndStopMaximum velocityMaximumHip ...
    velocityMaximumKnee

errorDetected = 0;
warningCount = 0;
messageWarning{1} = 'No warnings';

angleHip = hip.angleHip;
velocityHip = hip.dangleHip;
accelerationHip = hip.ddangleHip;

angleKnee = knee.angleKnee;
velocityKnee = knee.dangleKnee;
accelerationKnee = knee.ddangleKnee;

y = y.y;

%% end stop checker
outOfRangeHip = out_of_range(angleHip, angleHipEndStopMinimum, angleHipEndStopMaximum);
outOfRangeKnee = out_of_range(angleKnee, angleKneeEndStopMinimum, angleKneeEndStopMaximum);

[warningDetected, temporaryMessageWarning] = out_of_range_handler(outOfRangeHip, 'Hip angle becomes too low', 'Hip angle becomes too high');
if warningDetected
	warningCount = warningCount + 1;
    messageWarning{warningCount} = temporaryMessageWarning;
    warningDetected = 0;
end

[warningDetected, temporaryMessageWarning] = out_of_range_handler(outOfRangeKnee, 'Knee angle becomes too low', 'Knee angle becomes too high');
if warningDetected
	warningCount = warningCount + 1;
    messageWarning{warningCount} = temporaryMessageWarning;
    warningDetected = 0;
end

%% Velocity check
tooFastHip = out_of_range(velocityHip, -velocityMaximumHip, velocityMaximumHip);
tooFastKnee = out_of_range(velocityKnee, -velocityMaximumKnee, velocityMaximumKnee);

[warningDetected, temporaryMessageWarning] = out_of_range_handler(tooFastHip, 'Velocity of hip is too low.', 'Velocity of hip is too high.');
if warningDetected
	warningCount = warningCount + 1;
    messageWarning{warningCount} = temporaryMessageWarning;
    warningDetected = 0;
end

[warningDetected, temporaryMessageWarning] = out_of_range_handler(tooFastKnee, 'Velocity of knee is too low.', 'Velocity of knee is too high.');
if warningDetected
	warningCount = warningCount + 1;
    messageWarning{warningCount} = temporaryMessageWarning;
    warningDetected = 0;
end

%% y check

if sum(y > LProximal & angleHip > 0 & angleKnee > 0)
    warning('Your foor position is getting quite high, are you not overstrecthing?');
end