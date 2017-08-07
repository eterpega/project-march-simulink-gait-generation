function write_to_model_dictionary(myDictionaryObj, sectionObj, varNameKnee, varNameHip, gait)
         
         if exist(sectionObj, varNameKnee) && exist(sectionObj, varNameHip)
            
            kneeEntryObj=getEntry(sectionObj, varNameKnee);
            hipEntryObj=getEntry(sectionObj, varNameHip);
             
            setValue(kneeEntryObj, gait.splineKnee(:,2));
            setValue(hipEntryObj, gait.splineHip(:,2));
            
            saveChanges(myDictionaryObj);
            
            showChanges(kneeEntryObj)
            showChanges(hipEntryObj)
            
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
                    
                    showChanges(kneeEntryObj)
                    showChanges(hipEntryObj)
            end
         end