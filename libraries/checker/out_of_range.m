function outOfRange = out_of_range(value, valueMin, valueMax)

if max((value < valueMin))
    outOfRange = -1;
elseif max((value > valueMax))
    outOfRange = 1;
else
    outOfRange = 0;
end