function [positionXMinimum, positionXMaximum] = limit_position_x_position_y(positionY)

positionXMinimum = repmat(-0.8, 1, length(positionY));
positionXMaximum = repmat(0.8,  1, length(positionY));