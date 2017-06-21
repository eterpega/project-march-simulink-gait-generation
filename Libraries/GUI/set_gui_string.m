function [] = set_gui_string(vector, handle, property, format)
%Converts data in rowvector vector to a nice string format that is later
%used for display in the GUI.
%vector of data to convert to string with nice format
%handle of object to write to
%property of object to write to
%format of vector contents when converted to string. Example: '%2.2f'
%Example: setguistring([1, 2.23, 3, 4.56], textfieldHandle, 'String',
%'%2.2f')

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