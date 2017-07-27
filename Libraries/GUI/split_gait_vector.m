function [stepSwingLegHip, stepSwingLegKnee, stepStandLegHip, stepStandLegKnee]...
    =split_gait_vector(hipVector,kneeVector)

%Define vector lenght
lengthKneeVect=length(kneeVector)
lengthHipVect=length(hipVector)

%First half
stepSwingLegHip=hipVector(1:(lengthHipVect/2));
stepSwingLegKnee=kneeVector(1:(lengthKneeVect/2));

%Second halg
stepStandLegHip=hipVector((lengthHipVect/2+1):end);
stepStandLegKnee=kneeVector((lengthKneeVect/2+1):end);

length(stepStandLegHip)
length(stepStandLegKnee)
length(stepSwingLegHip)
length(stepSwingLegKnee)