function [warningDetected, messageWarning] = out_of_range_handler(outOfRange, messageMinimum, messageMaximum)
if (outOfRange == -1)
    warningDetected = 1;
    warning(messageMinimum);
    messageWarning{1} = messageMinimum;
elseif (outOfRange == 1)
    warningDetected = 1;
    warning(messageMaximum);
    messageWarning{1} = messageMaximum;
else
    warningDetected = 0;
    messageWarning{1} = 'This should not be here.';
end
