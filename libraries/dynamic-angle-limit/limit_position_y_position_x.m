function [positionYMinimum, positionYMaximum] = limit_position_y_position_x(positionX)

positionYMinimum = repmat(0,   1, length(positionX));
positionYMaximum = repmat(0.8, 1, length(positionX));