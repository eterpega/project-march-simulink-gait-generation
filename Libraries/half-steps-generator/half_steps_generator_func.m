function [startStandHalfStepHip,startStandHalfStepKnee,...
    startSwingHalfStepHip,startSwingHalfStepKnee,...
    stopHalfStepFromSwingKnee,stopHalfStepFromSwingHip,...
    stopHalfStepFromStandKnee,stopHalfStepFromStandHip]...
    = half_steps_generator_func(stepSwingLegHip, stepSwingLegKnee,...
    stepStandLegHip,stepStandLegKnee, standUpKnee, standUpHip)

%% START HALF STEP
%find index of stepStandLegKnee vector where angle==angle(standUpKnee(end))
IndexHalfStepStartKneeStand=find(stepStandLegKnee >= standUpKnee(end));
IndexHalfStepStartKneeSwing=find(stepSwingLegKnee >= standUpKnee(end));

%find index of stepStandLegHip vector where angle==angle(standUpHip(end))
IndexHalfStepStartHipStand=find(stepStandLegHip >= standUpHip(end));
IndexHalfStepStartHipSwing=find(stepSwingLegHip >= standUpHip(end));

%check knee index
%SWING
if ~isempty(IndexHalfStepStartKneeStand)
    IndexHalfStepStartKneeStand=IndexHalfStepStartKneeStand(1);
end

if ~isempty(IndexHalfStepStartKneeSwing)
    IndexHalfStepStartKneeSwing=IndexHalfStepStartKneeSwing(1);
end

%check hip index
%STAND
if ~isempty(IndexHalfStepStartHipStand)
    IndexHalfStepStartHipStand=IndexHalfStepStartHipStand(end);
end

if ~isempty(IndexHalfStepStartHipSwing)
    IndexHalfStepStartHipSwing=IndexHalfStepStartHipSwing(1);
end

%% DEFINE START HALF STEP FOR SWING LEG (RIGHT)
%truncate vector to right length to start at standUp(end)
startSwingHalfStepKnee=stepSwingLegKnee((IndexHalfStepStartKneeSwing+1):end);
startSwingHalfStepHip=stepSwingLegHip((IndexHalfStepStartHipSwing+1):end);

%Padding begin of vectors before standUp(end) angle is reached with standUp(en)
startSwingHalfStepHip=[ones(IndexHalfStepStartHipSwing,1)*standUpHip(end); startSwingHalfStepHip];
startSwingHalfStepKnee=[ones(IndexHalfStepStartKneeSwing,1)*standUpKnee(end); startSwingHalfStepKnee];

%% DEFINE START HALF STEP FOR STANCE LEG (LEFT)

%truncate vector to right length to start at standUp(end)
startStandHalfStepKnee=stepStandLegKnee((IndexHalfStepStartKneeStand+1):end);
startStandHalfStepHip=stepStandLegHip((IndexHalfStepStartHipStand+1):end);

%Padding begin of vectors before standUp(end) angle is reached with standUp(en)
startStandHalfStepHip=[ones(IndexHalfStepStartHipStand,1)*standUpHip(end); startStandHalfStepHip];
startStandHalfStepKnee=[ones(IndexHalfStepStartKneeStand,1)*standUpKnee(end); startStandHalfStepKnee];

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
stopHalfStepFromSwingHip    =[stopHalfStepFromSwingHip; ones((length(stepStandLegHip)-IndexHalfStepStopHipFromSwing),1)*startSwingHalfStepHip(1)];
stopHalfStepFromSwingKnee   =[stopHalfStepFromSwingKnee; ones((length(stepStandLegKnee)-IndexHalfStepStopKneeFromSwing),1)*stepStandLegKnee(1)];

%% DEFINE HALF STOP STEP FROM STAND
%vector for half step stop from stand leg
stopHalfStepFromStandHip=stepSwingLegHip(1:IndexHalfStepStopHipFromStand);
stopHalfStepFromStandKnee=stepSwingLegKnee(1:IndexHalfStepStopKneeFromStand);

%Padding 'from stand' vectors to hold position when stand angle is reached
stopHalfStepFromStandHip=[stopHalfStepFromStandHip; ones(length(stepSwingLegHip)-IndexHalfStepStopHipFromStand,1)*standUpHip(end)];
stopHalfStepFromStandKnee=[stopHalfStepFromStandKnee; ones(length(stepSwingLegKnee)-IndexHalfStepStopKneeFromStand,1)*standUpKnee(end)];

stopHalfStepFromStandKnee=stepStandLegKnee;
%% PLOT DATA

%plot half step stop from swing
fullSwingVectKnee    =[standUpKnee; startSwingHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee];
fullSwingVectHip     =[standUpHip; startSwingHalfStepHip; stepStandLegHip; stepSwingLegHip; stopHalfStepFromSwingHip];

%plot half step stop from stand
fullStandVectKnee=[standUpKnee; startStandHalfStepKnee; stepSwingLegKnee; stepStandLegKnee; stopHalfStepFromStandKnee];
fullStandVectHip=[standUpHip; startStandHalfStepHip; stepSwingLegHip; stepStandLegHip; stopHalfStepFromStandHip];

fullStartStopStandVectKnee=[standUpKnee; startStandHalfStepKnee; stopHalfStepFromStandKnee];
fullStartStopStandVectHip=[standUpHip; startStandHalfStepHip; stopHalfStepFromStandHip];

fullStartStopSwingVectKnee=[standUpKnee; startSwingHalfStepKnee; stopHalfStepFromSwingKnee];
fullStartStopSwingVectHip=[standUpHip; startSwingHalfStepHip; stopHalfStepFromSwingHip];

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
% line([length(standUpKnee) length(standUpKnee)], [-20 90])
% line([length([standUpKnee; startSwingHalfStepKnee]) length([standUpKnee; startSwingHalfStepKnee])], [-20 90])
% line([length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee]) length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee])], [-20 90])
% line([length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee; stepSwingLegKnee]) length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee; stepSwingLegKnee])], [-20 90])
% line([length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee]) length([standUpKnee; startSwingHalfStepKnee; stepStandLegKnee; stepSwingLegKnee; stopHalfStepFromSwingKnee])], [-20 90])
