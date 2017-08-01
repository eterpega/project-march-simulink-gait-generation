%function [startHalfStepHip, startHalfStepKnee, stopHalfStepKnee, stopHalfStepHip] = generate_half_steps(standUpHip, standUpKnee, stepStandLegHip, stepStandLegKnee)

close all

stopHalfStepFromStandHip=0;
stopHalfStepFromStandKnee=0;
stopHalfStepFromSwingHip=0;
stopHalfStepFromSwingKnee=0;


%% START HALF STEP
%find index of stepStandLegKnee vector where angle==angle(standUpKnee(end))
IndexHalfStepStartKneeStand=find(stepStandLegKnee >= standUpKnee(end));
IndexHalfStepStartKneeSwing=find(stepSwingLegKnee >= standUpKnee(end));

%find index of stepStandLegHip vector where angle==angle(standUpHip(end))
IndexHalfStepStartHipStand=find(stepStandLegHip >= standUpHip(end));
IndexHalfStepStartHipSwing=find(stepSwingLegHip >= standUpHip(end));

%check knee index
if ~isempty(IndexHalfStepStartKneeStep)
    IndexHalfStepStartKneeStand=IndexHalfStepStartKneeStand(1);
    disp('Start Knee Step')
end

if ~isempty(IndexHalfStepStartKneeSwing)
    IndexHalfStepStartKneeSwing=IndexHalfStepStartKneeSwing(1);
    disp('Start Knee Swing')
end

%check hip index
if ~isempty(IndexHalfStepStartHipStep)
    IndexHalfStepStartHipStand=IndexHalfStepStartHipStand(1);
    disp('Start Hip Step')
end

if ~isempty(IndexHalfStepStartHipSwing)
    IndexHalfStepStartHipSwing=IndexHalfStepStartHipSwing(1);
    disp('Start Hip Swing')
end

%truncate vector to right length to start at standUp(end)
startHalfStepKnee=stepSwingLegKnee((IndexHalfStepStartKneeSwing+1):end);
startHalfStepHip=stepSwingLegHip((IndexHalfStepStartHipSwing+1):end);

%Check length of vectors are consistent with total length
%length(startHalfStepKnee)+IndexHalfStepStartKneeSwing-length(stepSwingLegKnee)
%length(startHalfStepHip)+IndexHalfStepStartHipSwing-length(stepSwingLegHip)

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
    disp('Stop Knee Swing')
else
    IndexHalfStepStopKneeFromSwing=length(stepSwingLegKnee);
end
%Stand
if ~isempty(IndexHalfStepStopKneeFromStand)
    IndexHalfStepStopKneeFromStand=IndexHalfStepStopKneeFromStand(end);
    disp('Stop Knee Stand')
else
    IndexHalfStepStopKneeFromStand=length(stepStandLegKnee);
end

%check if hip index is not empty
%Swing
if ~isempty(IndexHalfStepStopHipFromSwing)
    IndexHalfStepStopHipFromSwing=IndexHalfStepStopHipFromSwing(end);
    disp('Stop Hip Swing')
else 
    IndexHalfStepStopHipFromSwing=length(stepSwingLegHip);
end
%Stand
if ~isempty(IndexHalfStepStopHipFromStand)
    IndexHalfStepStopHipFromStand=IndexHalfStepStopHipFromStand(1);
    disp('Stop Hip Stand')
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
fullStopVectKnee=[standUpKnee; startHalfStepKnee; stepStandLegKnee; stopHalfStepFromStandKnee];
fullStopVectHip=[standUpHip; startHalfStepHip; stepStandLegHip; stopHalfStepFromStandHip];

figure
hold on
plot(fullStopVectKnee)
plot(fullStopVectHip)
line([length(standUpKnee) length(standUpKnee)], [-20 90])
line([length([standUpKnee; startHalfStepKnee]) length([standUpKnee; startHalfStepKnee])], [-20 90])
line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee])], [-20 90])
line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee])], [-20 90])
line([length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee]) length([standUpKnee; startHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee])], [-20 90])
hold off
% 
