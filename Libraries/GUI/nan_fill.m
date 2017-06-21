function [str] = nan_fill(vector, endlength)
%%nan_fill gets a row vector and returns that vector in string form of length
%endlenght starting with the elements of the input vector and adding
%trailing NaNs till lenght(endlength) is reached
%This is necessary to fulfill the static Bus size in simulink (set to 20)
str=['[' num2str(vector) '  ' num2str(ones(1,endlength-length(vector))*NaN) ']'];
end
