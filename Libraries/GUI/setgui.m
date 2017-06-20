function [] = setguistring(vector, handle, property, format)
%vector of data to convert to string with nice format
%handle of object to write to
%property of object to write to
%format of vector contents when converted to string
    
%initialise strings
str='';

%write coordinates to strings
for n=1:length(vector)
    str=[str,num2str(vector(n),format),', '];
end

%%String formatting
%Remove last comma
str=str(1:end-2);
%Put brackets around
str=strcat('[',str,']');
%Set property equal to string
set(handle,property,str);