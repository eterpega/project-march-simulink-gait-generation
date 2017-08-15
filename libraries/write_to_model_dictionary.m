%Writes gait vectors for knee and hip to Model dictonary (MD) defined by
%'myDictionaryObj' in section 'sectionObj'.
%The variables are saved under the name 'varNameKnee' and 'varNameHip'
%data is taken from the gait struct

function write_to_model_dictionary(myDictionaryObj, sectionObj, varNameKnee, varNameHip, gait)
         
         %checks if variables already exist in the section of the MD
         if exist(sectionObj, varNameKnee) && exist(sectionObj, varNameHip)
            
             %get Entryobject of the specified variable
            kneeEntryObj=getEntry(sectionObj, varNameKnee);
            hipEntryObj=getEntry(sectionObj, varNameHip);
             
            %set value of the specified variable
            setValue(kneeEntryObj, gait.splineKnee(:,2));
            setValue(hipEntryObj, gait.splineHip(:,2));
            
            saveChanges(myDictionaryObj);
            
          elseif ~exist(sectionObj,varNameKnee) || ~exist(sectionObj,varNameHip)
              
            %Open question box for confirmation
            questionStr=['WARNING: Entries ', varNameKnee, ' and ', varNameHip,...
                ' do not yet exist in Model Dictionary. Are you sure you want to add them?'];
            titleStr='Add new entries to Model DataDictionary';
            choice=questdlg(questionStr,titleStr,'Yes','No','No');
            
            switch choice
                case 'No';
                    
                case 'Yes';
                    
                    kneeEntryObj = addEntry(sectionObj, varNameKnee, gait.splineKnee(:,2));
                    hipEntryObj = addEntry(sectionObj, varNameHip, gait.splineHip(:,2));
                    
                    saveChanges(myDictionaryObj);
            end
         end