function [hipAngleRad, kneeAngleRad, hipAngleDeg, kneeAngleDeg, lowerBack, upperLeg, lowerLeg] = process_gait_theft(data)
ankle=data(:,1:2);
knee=data(:,3:4);
hip=data(:,5:6);
back=data(:,7:8);

for n=1:length(ankle(:,1))
    %define vectors
    lowerBack(n,:)=[hip(n,1)-back(n,1),hip(n,2)-back(n,2)];
    upperLeg(n,:)=[knee(n,1)-hip(n,1),knee(n,2)-hip(n,2)];
    lowerLeg(n,:)=[ankle(n,1)-knee(n,1),ankle(n,2)-knee(n,2)];
    %compute hip angle
    cosThetaHip(n,1)=dot(lowerBack(n,:),upperLeg(n,:))/(norm(lowerBack(n,:))*norm(upperLeg(n,:)));
    hipAngleRad(n,1)=acos(cosThetaHip(n));
    hipAngleDeg=rad2deg(hipAngleRad);
    %find knee angle
    cosThetaKnee(n,1)=dot(upperLeg(n,:),lowerLeg(n,:))/(norm(upperLeg(n,:))*norm(lowerLeg(n,:)));
    kneeAngleRad(n,1)=acos(cosThetaKnee(n));
    kneeAngleDeg=rad2deg(kneeAngleRad);
end
