%function [smoothHalfStep] = smooth_half_step_generator(halfStepSwingStartKnee)
clear all
close all
clc

    dictionaryPath=strcat('..',filesep,'simulink-models',filesep,'Library'); %set datadictionary parent directory path
    dictionaryName='ModelDictionary.sldd'; %set datadictionary name
    fullDictionaryPath=[dictionaryPath filesep dictionaryName]; %construct full path name for data dictionary
    myDictionaryObj = Simulink.data.dictionary.open(fullDictionaryPath); %get datadictionary object
    sectionObj = getSection(myDictionaryObj,'Design Data'); %get datadictionary section object
    halfStepStopFromSwingHipEntryObj=getEntry(sectionObj,'halfStepStopFromSwingHip');
    halfStepStopFromSwingHip=getValue(halfStepStopFromSwingHipEntryObj);
    
maxAcceleration=2; %rad/s

truncatedHalfStepStart=flip(halfStepStopFromSwingHip*(pi/180));
velocityHalfStepStart=gradient(truncatedHalfStepStart);
previousMaxVelocity=velocityHalfStepStart(1);
n=1;

while velocityHalfStepStart(n+1)>previousMaxVelocity || velocityHalfStepStart(n+1)==previousMaxVelocity
    previousMaxVelocity=velocityHalfStepStart(n+1);
    n=n+1;
end

indexMaxVelocity=n+2;

thetaTangentHalfStepStart=truncatedHalfStepStart(indexMaxVelocity)-truncatedHalfStepStart(1);   %rad
omegaTangentHalfStepStart=previousMaxVelocity;        %rad

deltaT=0.002;

timeBackInTimeTheta=sqrt(2*thetaTangentHalfStepStart/maxAcceleration)
timeBackInTimeOmega=omegaTangentHalfStepStart/maxAcceleration

if timeBackInTimeTheta<timeBackInTimeOmega
    timeBackInTime=timeBackInTimeOmega;
else
    timeBackInTime=timeBackInTimeTheta;
end

indexBackInTime=round(timeBackInTime/deltaT);

indexStartSmooth=indexMaxVelocity-indexBackInTime;

for smoothIndex=1:indexBackInTime;
    smoothHalfStep(smoothIndex,1)=truncatedHalfStepStart(1)+(0.5*maxAcceleration*(smoothIndex*deltaT)^2);
end
indexPad=indexMaxVelocity-indexBackInTime;

fullSmoothHalfStepStart=[repmat(truncatedHalfStepStart(1),indexPad,1);smoothHalfStep(:);truncatedHalfStepStart(indexMaxVelocity:end)];
 figure
plot(flip(fullSmoothHalfStepStart));
figure
plot(flip(gradient(fullSmoothHalfStepStart)),'+');
