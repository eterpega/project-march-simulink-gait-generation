
%% INITIALIZE
clear all; close all; clc

[PATHSTR,~,~] = fileparts(mfilename('fullpath'));
cd(PATHSTR);
%SET datadictionary parent directory path
dictionaryPath=strcat('..',filesep,'..',filesep,'simulink-models',filesep,'Library');
%set datadictionary name
dictionaryName='ModelDictionary.sldd'; 
%construct full path name for data dictionary
fullDictionaryPath=[dictionaryPath filesep dictionaryName]; 
%get datadictionary object
myDictionaryObj = Simulink.data.dictionary.open(fullDictionaryPath);
%get datadictionary section object
sectionObj = getSection(myDictionaryObj,'Design Data'); 

%% Get EntryObjets
%STEP
kneeSwingEntryObj   = getEntry(sectionObj,'stepSwingLegKnee'); %get entryObj for knee walk
hipSwingEntryObj    = getEntry(sectionObj,'stepSwingLegHip');   %get entryObj for hip walk
kneeStandEntryObj   = getEntry(sectionObj,'stepStandLegKnee'); %get entryObj for knee walk
hipStandEntryObj    = getEntry(sectionObj,'stepStandLegHip');   %get entryObj for hip walk
%STANDUP
kneeStandUpEntryObj = getEntry(sectionObj,'standUpKnee');    %get entryObj for knee stand up
hipStandUpEntryObj  = getEntry(sectionObj,'standUpHip');      %get entryObj for hip stand up
kneeInitStandUpEntryObj  = getEntry(sectionObj,'initializeStandUpKnee');      %get entryObj for knee init sit down
hipInitStandUpEntryObj  = getEntry(sectionObj,'initializeStandUpHip');      %get entryObj for hip init sit down
%SITDOWN
kneeSitDownEntryObj = getEntry(sectionObj,'sitDownKnee');    %get entryObj for knee sit down
hipSitDownEntryObj  = getEntry(sectionObj,'sitDownHip');      %get entryObj for hip sit down
kneeInitSitDownEntryObj  = getEntry(sectionObj,'initializeSitDownKnee');      %get entryObj for knee init sit down
hipInitSitDownEntryObj  = getEntry(sectionObj,'initializeSitDownHip');      %get entryObj for hip init sit down
%HALF STEPS
startStandHalfStepHipEntryObj   = getEntry(sectionObj,'halfStepStandStartHip');
startStandHalfStepKneeEntryObj  = getEntry(sectionObj,'halfStepStandStartKnee');
startSwingHalfStepHipEntryObj   = getEntry(sectionObj,'halfStepSwingStartHip');
startSwingHalfStepKneeEntryObj  = getEntry(sectionObj,'halfStepSwingStartKnee');
stopStepFromSwingKneeEntryObj   = getEntry(sectionObj,'halfStepStopFromSwingKnee');
stopStepFromSwingHipEntryObj    = getEntry(sectionObj,'halfStepStopFromSwingHip');
stopStepFromStandKneeEntryObj   = getEntry(sectionObj,'halfStepStopFromStandKnee');
stopStepFromStandHipEntryObj    = getEntry(sectionObj,'halfStepStopFromStandHip');
%STAIRS
stairsUpRightKneeEntryObj= getEntry(sectionObj,'stairsUpRightKnee');
stairsUpRightHipEntryObj= getEntry(sectionObj,'stairsUpRightHip');
stairsUpLeftKneeEntryObj= getEntry(sectionObj,'stairsUpLeftKnee');
stairsUpLeftHipEntryObj= getEntry(sectionObj,'stairsUpLeftHip');
stairsDownRightKneeEntryObj= getEntry(sectionObj,'stairsDownRightKnee');
stairsDownRightHipEntryObj= getEntry(sectionObj,'stairsDownRightHip');
stairsDownLeftKneeEntryObj= getEntry(sectionObj,'stairsDownLeftKnee');
stairsDownLeftHipEntryObj= getEntry(sectionObj,'stairsDownLeftHip');

%% Get Values from model dictionnary
%STEP
S.stepSwingLegHip             = getValue(hipSwingEntryObj);     
S.stepSwingLegKnee            = getValue(kneeSwingEntryObj);   
S.stepStandLegHip             = getValue(hipStandEntryObj); 
S.stepStandLegKnee            = getValue(kneeStandEntryObj);
%STANDUP
S.standUpKnee                 = getValue(kneeStandUpEntryObj);
S.standUpHip                  = getValue(hipStandUpEntryObj);
S.initializeStandUpKnee       = getValue(kneeInitStandUpEntryObj);
S.initializeStandUpHip        = getValue(hipInitStandUpEntryObj);
%SITDOWN
S.sitDownKnee                 = getValue(kneeSitDownEntryObj);
S.sitDownHip                  = getValue(hipSitDownEntryObj);
S.initializeSitDownKnee       = getValue(kneeInitSitDownEntryObj);
S.initializeSitDownHip        = getValue(hipInitSitDownEntryObj);
%HALF STEPS
S.halfStepStandStartHip       = getValue(startStandHalfStepHipEntryObj);
S.halfStepStandStartKnee      = getValue(startStandHalfStepKneeEntryObj);
S.halfStepSwingStartHip       = getValue(startSwingHalfStepHipEntryObj);
S.halfStepSwingStartKnee      = getValue(startSwingHalfStepKneeEntryObj);
S.halfStepStopFromSwingKnee   = getValue(stopStepFromSwingKneeEntryObj);
S.halfStepStopFromSwingHip    = getValue(stopStepFromSwingHipEntryObj);
S.halfStepStopFromStandKnee   = getValue(stopStepFromStandKneeEntryObj);
S.halfStepStopFromStandHip    = getValue(stopStepFromStandHipEntryObj);
%STAIRS
S.stairsUpRightKnee           = getValue(stairsUpRightKneeEntryObj);
S.stairsUpRightHip            = getValue(stairsUpRightHipEntryObj);
S.stairsUpLeftKnee            = getValue(stairsUpLeftKneeEntryObj);
S.stairsUpLeftHip             = getValue(stairsUpLeftHipEntryObj);
S.stairsDownRightKnee         = getValue(stairsDownRightKneeEntryObj);
S.stairsDownRightHip          = getValue(stairsDownRightHipEntryObj);
S.stairsDownLeftKnee          = getValue(stairsDownLeftKneeEntryObj);
S.stairsDownLeftHip           = getValue(stairsDownLeftHipEntryObj);


%% PLOT DATA

%plot half step stop from swing
fullSwingVectKnee    =[S.initializeStandUpKnee; S.standUpKnee; S.halfStepSwingStartKnee ; S.stepStandLegKnee; S.stepSwingLegKnee; S.halfStepStopFromSwingKnee; S.initializeSitDownKnee; S.sitDownKnee];
fullSwingVectHip     =[S.initializeStandUpHip; S.standUpHip; S.halfStepSwingStartHip; S.stepStandLegHip; S.stepSwingLegHip; S.halfStepStopFromSwingHip; S.initializeSitDownHip;S.sitDownHip];

if length(fullSwingVectKnee)~=length(fullSwingVectHip)
    error('Error: Vectors of the 1st plot are not the same length')
end

%plot half step stop from stand
fullStandVectKnee=[S.initializeStandUpKnee; S.standUpKnee; S.halfStepStandStartKnee; S.stepSwingLegKnee; S.stepStandLegKnee; S.halfStepStopFromStandKnee; S.initializeSitDownKnee;S.sitDownKnee];
fullStandVectHip=[S.initializeStandUpHip; S.standUpHip; S.halfStepStandStartHip; S.stepSwingLegHip; S.stepStandLegHip; S.halfStepStopFromStandHip; S.initializeSitDownHip;S.sitDownHip];

if length(fullStandVectKnee)~=length(fullStandVectHip)
    error('Error: Vectors of the 2nd plot are not the same length')
end

fullStartStopStandVectKnee=[S.initializeStandUpKnee; S.standUpKnee; S.halfStepStandStartKnee; S.halfStepStopFromStandKnee; S.initializeSitDownKnee;S.sitDownKnee];
fullStartStopStandVectHip=[S.initializeStandUpHip; S.standUpHip; S.halfStepStandStartHip; S.halfStepStopFromStandHip; S.initializeSitDownHip;S.sitDownHip];

if length(fullStartStopStandVectKnee)~=length(fullStartStopStandVectHip)
    error('Error: Vectors of the 3rd plot are not the same length')
end

fullStartStopSwingVectKnee=[S.initializeStandUpKnee; S.standUpKnee; S.halfStepSwingStartKnee; S.halfStepStopFromSwingKnee; S.initializeSitDownKnee;S.sitDownKnee];
fullStartStopSwingVectHip=[S.initializeStandUpHip; S.standUpHip; S.halfStepSwingStartHip; S.halfStepStopFromSwingHip; S.initializeSitDownHip;S.sitDownHip];

if length(fullStartStopSwingVectKnee)~=length(fullStartStopSwingVectHip)
    error('Error: Vectors of the 4th plot are not the same length')
end

figure
subplot(4,1,1)
hold on
title('Stand, StartSwing, Walk, StopfromSwing')
plot(fullSwingVectKnee)
plot(fullSwingVectHip)
hold off

subplot(4,1,2)
hold on
title('Stand, StartStand, Walk, StopfromStand')
plot(fullStandVectKnee)
plot(fullStandVectHip)
hold off

subplot(4,1,3)
hold on
title('Stand, StartStand, StopfromStand')
plot(fullStartStopStandVectKnee)
plot(fullStartStopStandVectHip)
hold off

subplot(4,1,4)
hold on
title('Stand, StartSwing, StopfromSwing')
plot(fullStartStopSwingVectKnee)
plot(fullStartStopSwingVectHip)
hold off

waitforbuttonpress

%% SAVE
%save file after User confirmation
[fileName,pathName]=uiputfile(['..' filesep 'gait-data' filesep 'GaitVectors'],...
    'Where do you want to save the gait vectors?','newGaitVectors.mat');
save([pathName filesep fileName],'-struct','S');
