%This script gets the standUp, stepStand and stepSwing vectors for Knee
%and Hip from the model dictionary. If the variables do not exist an error
%is given.
%Based on these vectors it constructs vectors for the start and stop half
%steps.
%For the stop half steps, 2 different vectors are needed depending on
%whether the leg is currently a stance or swing leg
%Finally the half step vectors are added to the Model Dictionary.
%If the variable do not exist yet they are added after confirmation has
%been given for the user

%To make this work the user needs to define the path to the model
%dictionary in the INITIALIZE section

%% INITIALIZE
close all; clear all; clc

%SET datadictionary parent directory path
dictionaryPath='/Users/lucadelaat/Desktop/MARCH/simulink-models/Library';
%set datadictionary name
dictionaryName='ModelDictionary.sldd'; 
%construct full path name for data dictionary
fullDictionaryPath=[dictionaryPath filesep dictionaryName]; 
%get datadictionary object
myDictionaryObj = Simulink.data.dictionary.open(fullDictionaryPath);
%get datadictionary section object
sectionObj = getSection(myDictionaryObj,'Design Data'); 

kneeSwingEntryObj   = getEntry(sectionObj,'stepSwingLegKnee'); %get entryObj for knee walk
hipSwingEntryObj    = getEntry(sectionObj,'stepSwingLegHip');   %get entryObj for hip walk
kneeStandEntryObj   = getEntry(sectionObj,'stepStandLegKnee'); %get entryObj for knee walk
hipStandEntryObj    = getEntry(sectionObj,'stepStandLegHip');   %get entryObj for hip walk
kneeStandUpEntryObj = getEntry(sectionObj,'standUpKnee');    %get entryObj for knee stand up
hipStandUpEntryObj  = getEntry(sectionObj,'standUpHip');      %get entryObj for hip stand up

     if ~isempty(kneeSwingEntryObj) && ~isempty(hipSwingEntryObj)...
             && ~isempty(kneeStandEntryObj) && ~isempty(hipStandEntryObj)

         %Get Values from model dictionnary
        stepSwingLegHip     = getValue(hipSwingEntryObj);     
        stepSwingLegKnee    = getValue(kneeSwingEntryObj);   
        stepStandLegHip     = getValue(hipStandEntryObj); 
        stepStandLegKnee    = getValue(kneeStandEntryObj);
        standUpKnee         = getValue(kneeStandEntryObj);
        standUpHip          = getValue(kneeStandEntryObj);

     %give error if entryObjs are empty   
     elseif isempty(kneeSwingEntryObj) || isempty(hipSwingEntryObj)...
             || isempty(kneeStandEntryObj) || isempty(hipStandEntryObj) 
        msgbox('ERROR: entries found in DataDictionary are not valid','Error: DD entries','error')
        return
     end
     
%% START HALF STEP
%find index of stepStandLegKnee vector where angle==angle(standUpKnee(end))
IndexHalfStepStartKneeStand=find(stepStandLegKnee >= standUpKnee(end));
IndexHalfStepStartKneeSwing=find(stepSwingLegKnee >= standUpKnee(end));

%find index of stepStandLegHip vector where angle==angle(standUpHip(end))
IndexHalfStepStartHipStand=find(stepStandLegHip >= standUpHip(end));
IndexHalfStepStartHipSwing=find(stepSwingLegHip >= standUpHip(end));

%check knee index
if ~isempty(IndexHalfStepStartKneeStand)
    IndexHalfStepStartKneeStand=IndexHalfStepStartKneeStand(1);
end

if ~isempty(IndexHalfStepStartKneeSwing)
    IndexHalfStepStartKneeSwing=IndexHalfStepStartKneeSwing(1);
end

%check hip index
if ~isempty(IndexHalfStepStartHipStand)
    IndexHalfStepStartHipStand=IndexHalfStepStartHipStand(1);
end

if ~isempty(IndexHalfStepStartHipSwing)
    IndexHalfStepStartHipSwing=IndexHalfStepStartHipSwing(1);
end


%truncate vector to right length to start at standUp(end)
startHalfStepKnee=stepSwingLegKnee((IndexHalfStepStartKneeSwing+1):end);
startHalfStepHip=stepSwingLegHip((IndexHalfStepStartHipSwing+1):end);

%Padding begin of vectors before standUp(end) angle is reached with standUp(en)
startHalfStepHip=[ones(IndexHalfStepStartHipSwing,1)*standUpHip(end); startHalfStepHip];
startHalfStepKnee=[ones(IndexHalfStepStartKneeSwing,1)*standUpKnee(end); startHalfStepKnee];

%% STOP HALF STEP

%find index of stepStandLegKnee vector where angle>=angle(standUpKnee(end))
IndexHalfStepStopKneeFromStand=find(stepSwingLegKnee >= standUpKnee(end));
IndexHalfStepStopKneeFromSwing=find(stepStandLegKnee >= standUpKnee(end));

%find index of stepStandLegHip vector where angle>=angle(standUpHip(end))
IndexHalfStepStopHipFromStand=find(stepSwingLegHip >= standUpHip(end));
IndexHalfStepStopHipFromSwing=find(stepStandLegHip >= standUpHip(end));

%check knee index is not empty
%Swing
if ~isempty(IndexHalfStepStopKneeFromSwing)
    IndexHalfStepStopKneeFromSwing=IndexHalfStepStopKneeFromSwing(end);
else
    IndexHalfStepStopKneeFromSwing=length(stepSwingLegKnee);
end
%Stand
if ~isempty(IndexHalfStepStopKneeFromStand)
    IndexHalfStepStopKneeFromStand=IndexHalfStepStopKneeFromStand(end);
else
    IndexHalfStepStopKneeFromStand=length(stepStandLegKnee);
end

%check if hip index is not empty
%Swing
if ~isempty(IndexHalfStepStopHipFromSwing)
    IndexHalfStepStopHipFromSwing=IndexHalfStepStopHipFromSwing(end);
else 
    IndexHalfStepStopHipFromSwing=length(stepSwingLegHip);
end
%Stand
if ~isempty(IndexHalfStepStopHipFromStand)
    IndexHalfStepStopHipFromStand=IndexHalfStepStopHipFromStand(1);
else
    IndexHalfStepStopHipFromStand=length(stepStandLegHip);
end

%% DEFINE HALF STOP STEP FROM SWING
%vector for half step stop from swing leg
stopHalfStepFromSwingHip    =stepStandLegHip(1:IndexHalfStepStopHipFromSwing);
stopHalfStepFromSwingKnee   =stepStandLegKnee(1:IndexHalfStepStopKneeFromSwing);

%Padding 'from swing' vectors when stand angle is reached
stopHalfStepFromSwingHip    =[stopHalfStepFromSwingHip; ones((length(stepStandLegHip)-IndexHalfStepStopHipFromSwing),1)*startHalfStepHip(1)];
stopHalfStepFromSwingKnee   =[stopHalfStepFromSwingKnee; ones((length(stepStandLegKnee)-IndexHalfStepStopKneeFromSwing),1)*stepStandLegKnee(1)];

%% DEFINE HALF STOP STEP FROM STAND
%vector for half step stop from stand leg
stopHalfStepFromStandHip=stepSwingLegHip(1:IndexHalfStepStopHipFromStand);
stopHalfStepFromStandKnee=stepSwingLegKnee(1:IndexHalfStepStopKneeFromStand);

%Padding 'from stand' vectors to hold position when stand angle is reached
stopHalfStepFromStandHip=[stopHalfStepFromStandHip; ones(length(stepSwingLegHip)-IndexHalfStepStopHipFromStand,1)*standUpHip(end)];
stopHalfStepFromStandKnee=[stopHalfStepFromStandKnee; ones(length(stepSwingLegKnee)-IndexHalfStepStopKneeFromStand,1)*standUpKnee(end)];

%% PLOT DATA

%%plot half step stop from swing
%fullStopVectKnee    =[standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee];
%fullStopVectHip     =[standUpHip; startHalfStepHip; stepStandLegHip; stepSwingLegHip; stopHalfStepFromSwingHip];

%%plot half step stop from stand
% fullStopVectKnee=[standUpKnee; startHalfStepKnee; stepStandLegKnee; stopHalfStepFromStandKnee];
% fullStopVectHip=[standUpHip; startHalfStepHip; stepStandLegHip; stopHalfStepFromStandHip];
% 
% figure
% hold on
% plot(fullStopVectKnee)
% plot(fullStopVectHip)
% line([length(standUpKnee) length(standUpKnee)], [-20 90])
% line([length([standUpKnee; startHalfStepKnee]) length([standUpKnee; startHalfStepKnee])], [-20 90])
% line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee])], [-20 90])
% line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee])], [-20 90])
% line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee])], [-20 90])
% hold off

%% SAVE HALF STEPS TO MODEL DICTIONARY

%Define variable names
varNameStartStepHip             = 'halfStepStartHip';
varNameStartStepKnee            = 'halfStepStartKnee';
varNameStopStepFromSwingKnee    = 'halfStepStopFromSwingKnee';
varNameStopStepFromSwingHip     = 'halfStepStopFromSwingHip';
varNameStopStepFromStandKnee    = 'halfStepStopFromStandKnee';
varNameStopStepFromStandHip     = 'halfStepStopFromStandHip';
         
     if exist(sectionObj, varNameStartStepHip) && exist(sectionObj, varNameStartStepKnee)...
             && exist(sectionObj, varNameStopStepFromSwingKnee) && exist(sectionObj, varNameStopStepFromSwingHip)...
             && exist(sectionObj, varNameStopStepFromStandKnee) && exist(sectionObj, varNameStopStepFromStandHip)
        
        %Get entry object from data dictionary 
        startStepHipEntryObj            = getEntry(sectionObj,varNameStartStepHip);
        startStepKneeEntryObj           = getEntry(sectionObj,varNameStartStepKnee);
        stopStepFromSwingKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromSwingKnee);
        stopStepFromSwingHipEntryObj    = getEntry(sectionObj,varNameStopStepFromSwingHip);
        stopStepFromStandKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromStandKnee);
        stopStepFromStandHipEntryObj    = getEntry(sectionObj,varNameStopStepFromStandHip);

        %Set Values in Data Dictionary
        setValue(startStepHipEntryObj, startHalfStepHip);
        setValue(startStepKneeEntryObj, startHalfStepKnee);
        setValue(stopStepFromSwingKneeEntryObj ,stopHalfStepFromSwingKnee);
        setValue(stopStepFromSwingHipEntryObj  ,stopHalfStepFromSwingHip);
        setValue(stopStepFromStandKneeEntryObj ,stopHalfStepFromStandKnee);
        setValue(stopStepFromStandHipEntryObj  ,stopHalfStepFromStandHip);
 
        saveChanges(myDictionaryObj);

      elseif ~exist(sectionObj, varNameStartStepHip) || ~exist(sectionObj, varNameStartStepKnee)...
            || ~exist(sectionObj, varNameStopStepFromSwingKnee) || ~exist(sectionObj, varNameStopStepFromSwingHip)...
            || ~exist(sectionObj, varNameStopStepFromStandKnee) || ~exist(sectionObj, varNameStopStepFromStandHip)
        
        %Open question box for confirmation
        questionStr=['WARNING: Some or all of the half step vector Entries ',...
            'do not yet exist in Model Dictionary. Are you sure you want to add them?'];
        titleStr='Add half steps to Model DataDictionary';
        choice=questdlg(questionStr,titleStr,'Yes','No','No');

        switch choice
            case 'No';
                return
                
            case 'Yes';
                %Add Entries in Data Dictionary
                startStepHipEntryObj            = addEntry(sectionObj,varNameStartStepHip, startHalfStepHip);
                startStepKneeEntryObj           = addEntry(sectionObj,varNameStartStepKnee, startHalfStepKnee);
                stopStepFromSwingKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromSwingKnee, stopHalfStepFromSwingKnee);
                stopStepFromSwingHipEntryObj    = addEntry(sectionObj,varNameStopStepFromSwingHip, stopHalfStepFromSwingHip);
                stopStepFromStandKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromStandKnee, stopHalfStepFromStandKnee);
                stopStepFromStandHipEntryObj    = addEntry(sectionObj,varNameStopStepFromStandHip, stopHalfStepFromStandHip);

                saveChanges(myDictionaryObj);
        end
     end