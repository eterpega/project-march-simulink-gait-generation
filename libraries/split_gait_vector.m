%splits the continuous gait vector in 2.
%Is necessary because the gait Handler in HighLevelMARCH makes a difference 
%between the stance and swing leg 

function [stepSwingLegHip, stepSwingLegKnee, stepStandLegHip, stepStandLegKnee]...
    =split_gait_vector(hipVector,kneeVector)

%Define vector lenght
lengthKneeVect = length(kneeVector);
lengthHipVect = length(hipVector);

%split first half
stepSwingLegHip = hipVector(1:(lengthHipVect/2));
stepSwingLegKnee = kneeVector(1:(lengthKneeVect/2));

%split second half
stepStandLegHip = hipVector((lengthHipVect/2+1):end);
stepStandLegKnee = kneeVector((lengthKneeVect/2+1):end);