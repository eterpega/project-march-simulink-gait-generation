clear all; close all; clc

structSitDownHip=open('RW_SitDown_KeyEvent_2.5_Hip.mat');
structSitDownKnee=open('RW_SitDown_KeyEvent_2.5_Knee.mat');
structStandUpHip=open('StandUp_1.9_Hip.mat');
structStandUpKnee=open('StandUp_1.9_Knee.mat');

sitDownHip=structSitDownHip.hipVect;
sitDownKnee=structSitDownKnee.kneeVect;
standUpHip=structStandUpHip.hipVect;
standUpKnee=structStandUpKnee.kneeVect;

fileName='min10deg_vectors.mat';

save(fileName,'sitDownHip');
save(fileName,'sitDownKnee','-append');
save(fileName,'standUpHip','-append');
save(fileName,'standUpKnee','-append');