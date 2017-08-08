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
     
%% RUN half_steps_generator_func
[startStandHalfStepHip,startStandHalfStepKnee,...
    startSwingHalfStepHip,startSwingHalfStepKnee,...
    stopHalfStepFromSwingKnee,stopHalfStepFromSwingHip,...
    stopHalfStepFromStandKnee,stopHalfStepFromStandHip]...
    = half_steps_generator_func(stepSwingLegHip, stepSwingLegKnee,...
    stepStandLegHip,stepStandLegKnee, standUpKnee, standUpHip);

%% USER CHECK IF VECTORS ARE CONTINUOUS
questionStr=['Are all the gait vectors continuous?'];
    titleStr='Check if the gait vectors are continuous';
    choice1=questdlg(questionStr,titleStr,'Yes','No','No');
        
switch choice1
    case 'No'
        return
        
    case 'Yes'
%% SAVE HALF STEPS TO MODEL DICTIONARY

%Define variable names
varNameStartStandHalfStepHip    = 'halfStepStandStartHip';
varNameStartStandHalfStepKnee   = 'halfStepStandStartKnee';
varNameStartSwingHalfStepHip    = 'halfStepSwingStartHip';
varNameStartSwingHalfStepKnee   = 'halfStepSwingStartKnee';
varNameStopStepFromSwingKnee    = 'halfStepStopFromSwingKnee';
varNameStopStepFromSwingHip     = 'halfStepStopFromSwingHip';
varNameStopStepFromStandKnee    = 'halfStepStopFromStandKnee';
varNameStopStepFromStandHip     = 'halfStepStopFromStandHip';

         
     if exist(sectionObj, varNameStartStandHalfStepHip) && exist(sectionObj, varNameStartStandHalfStepKnee)...
             && exist(sectionObj, varNameStartSwingHalfStepHip) && exist(sectionObj, varNameStartSwingHalfStepKnee)...
             && exist(sectionObj, varNameStopStepFromSwingKnee) && exist(sectionObj, varNameStopStepFromSwingHip)...
             && exist(sectionObj, varNameStopStepFromStandKnee) && exist(sectionObj, varNameStopStepFromStandHip)
        
        %Get entry object from data dictionary 
        startStandHalfStepHipEntryObj   = getEntry(sectionObj,varNameStartStandHalfStepHip);
        startStandHalfStepKneeEntryObj  = getEntry(sectionObj,varNameStartStandHalfStepKnee);
        startSwingHalfStepHipEntryObj   = getEntry(sectionObj,varNameStartSwingHalfStepHip);
        startSwingHalfStepKneeEntryObj  = getEntry(sectionObj,varNameStartSwingHalfStepKnee);
        stopStepFromSwingKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromSwingKnee);
        stopStepFromSwingHipEntryObj    = getEntry(sectionObj,varNameStopStepFromSwingHip);
        stopStepFromStandKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromStandKnee);
        stopStepFromStandHipEntryObj    = getEntry(sectionObj,varNameStopStepFromStandHip);

        %Set Values in Data Dictionary
        setValue(startStandHalfStepHipEntryObj, startStandHalfStepHip);
        setValue(startStandHalfStepKneeEntryObj, startStandHalfStepKnee);
        setValue(startSwingHalfStepHipEntryObj, startSwingHalfStepHip);
        setValue(startSwingHalfStepKneeEntryObj, startSwingHalfStepKnee);
        setValue(stopStepFromSwingKneeEntryObj ,stopHalfStepFromSwingKnee);
        setValue(stopStepFromSwingHipEntryObj  ,stopHalfStepFromSwingHip);
        setValue(stopStepFromStandKneeEntryObj ,stopHalfStepFromStandKnee);
        setValue(stopStepFromStandHipEntryObj  ,stopHalfStepFromStandHip);
 
        saveChanges(myDictionaryObj);

      elseif ~exist(sectionObj, varNameStartStandHalfStepHip) || ~exist(sectionObj, varNameStartStandHalfStepKnee)...
            || ~exist(sectionObj, varNameStartSwingHalfStepHip) || ~exist(sectionObj, varNameStartSwingHalfStepKnee)...
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
                startStandHalfStepHipEntryObj   = addEntry(sectionObj,varNameStartStandHalfStepHip, startStandHalfStepHip);
                startStandHalfStepKneeEntryObj  = addEntry(sectionObj,varNameStartStandHalfStepKnee, startStandHalfStepKnee);
                startSwingHalfStepHipEntryObj   = addEntry(sectionObj,varNameStartSwingHalfStepHip, startSwingHalfStepHip);
                startSwingHalfStepKneeEntryObj  = addEntry(sectionObj,varNameStartSwingHalfStepKnee, startSwingHalfStepKnee);
                stopStepFromSwingKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromSwingKnee, stopHalfStepFromSwingKnee);
                stopStepFromSwingHipEntryObj    = addEntry(sectionObj,varNameStopStepFromSwingHip, stopHalfStepFromSwingHip);
                stopStepFromStandKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromStandKnee, stopHalfStepFromStandKnee);
                stopStepFromStandHipEntryObj    = addEntry(sectionObj,varNameStopStepFromStandHip, stopHalfStepFromStandHip);

                saveChanges(myDictionaryObj);
        end
     end
end