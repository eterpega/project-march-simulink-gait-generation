function [warningDetected, messageWarning] = out_of_range_handler(outOfRange, messageMinimum, messageMaximum)
if (outOfRange == -1)
    warningDetected = 1;
    warning(messageMinimum);
    messageWarning = messageMinimum;
elseif (outOfRange == 1)
    warningDetected = 1;
    warning(messageMaximum);
    messageWarning = messageMaximum;
else
    warningDetected = 0;
    messageWarning = 'This should not be here.';
end
