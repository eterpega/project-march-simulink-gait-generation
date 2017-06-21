function [str] = Nanfill(vector, endlength)
str=['[' num2str(vector) '  ' num2str(ones(1,endlength-length(vector))*NaN) ']'];
end
