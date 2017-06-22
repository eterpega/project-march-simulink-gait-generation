function [errorDetected, warningDetected, message] = gait_checker(hip, knee, x, y, foot, stanceLegRight, stanceLegLeft,stepLength);
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

angleHipMin = degree_to_rad(-20);
angleHipMax = degree_to_rad(110);
angleKneeMin = degree_to_rad(-5);
angleKneeMax = degree_to_rad(110);

outOfRangeHip = out_of_range(angleHip, angleHipMin, angleHipMax);
outOfRangeKnee = out_of_range(angleKnee, angleKneeMin, angleKneeMax);

out_of_range_handler(outOfRangeHip, 'Hip angle becomes too low', 'Hip angle becomes too high');
out_of_range_handler(outOfRangeKnee, 'Knee angle becomes too low', 'Knee angle becomes too high');


%% Velocity check
if (max(abs(velocityHip) > velocityHipMax))
    warningDetected = 1;
    message = 'Velocity of hip is too high.';
end

if (max(abs(velocityKnee) > velocityKneeMax))
    warningDetected = 1;
    message = 'Velocity of knee is too high.';
end
