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
    dotHip=lowerBack(n,1) * upperLeg(n,1) + lowerBack(n,2) * upperLeg(n,2);
    detHip=lowerBack(n,1) * upperLeg(n,2) - lowerBack(n,2) * upperLeg(n,1);
    hipAngleRad(n,1)=-atan2(detHip,dotHip);
    hipAngleDeg(n,1)=rad2deg(hipAngleRad(n,1));

    %compute knee angle
    dotKnee=upperLeg(n,1) * lowerLeg(n,1) + upperLeg(n,2) * lowerLeg(n,2);
    detKnee=upperLeg(n,1) * lowerLeg(n,2) - upperLeg(n,2) * lowerLeg(n,1);
    kneeAngleRad(n,1)=atan2(detKnee,dotKnee);
    kneeAngleDeg(n,1)=rad2deg(kneeAngleRad(n,1));
    
end

