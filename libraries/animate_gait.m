function animate_gait(xRight,yRight,xLeft,yLeft,sampleFrequency,samplePointAmount,stepLength, dynamic)
% This function playes back the leg positions at the correct speed.

if ~dynamic
    stepLength = 0;
end

%%Create and intialize plot
p = figure('Position', [200,200,500,400]); %create figure
axis([-0.55 0.55, 0 , 1.1])
grid on
axis square
xlabel('x [m]')
ylabel('y [m]')
title('Gait Animation')

%% Find play back time
fps = 25;   %[Hz] the fps at which we want to play the animation
Ttimer = 1/fps; %[s] the delay in between refreshing frames.
iInterval = sampleFrequency/fps; %Which frames we wat to display
tic %start timer

%% Play animation
i = 1;
stepAmount = 0;
while true  %if not stopped it will play back forever
    tic %[s] start timer
    i = i + iInterval; %Determine which frame needs to be played next
    
    i = mod(i,samplePointAmount); %make sure it is always in the vector range
    if i < iInterval
    	stepAmount = stepAmount + 2;
    end
    
    if ishandle(p) %if the figure p is not closed
        figure(p);
        hold on
        
        xRightActual = xRight(:,i)+stepAmount*stepLength;
        xLeftActual = xLeft(:,i)+stepAmount*stepLength;
        
        Right = plot(xRightActual, yRight(:,i),'Color','g');
        hold on
        Left = plot(xLeftActual, yLeft(:,i),'Color','r');
        drawnow
        
        %wait some time, so the gait is played back at an accurate speed.
        while true
            if ~(toc < Ttimer)
                break
            end
        end
        
        delete(Right)
        delete(Left)
    else %If figure p is closed, stop animation.
        break
    end
end