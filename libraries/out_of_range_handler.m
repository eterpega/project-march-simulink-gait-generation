function [errorDetected] = out_of_range_handler(outOfRange, messageMin, messageMax)
if (outOfRange == -1)
    errorDetected = 1;
    warning(messageMin);
elseif (outOfRange == 1)
    errorDetected = 1;
    warning(messageMax);
end
