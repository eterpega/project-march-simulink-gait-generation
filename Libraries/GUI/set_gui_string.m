function [] = set_gui_string(gethandle, gaitvar, sethandle, property, format, convFac)
%vector of data to convert to string with nice format
%handle of object to write to
%property of object to write to
%format of vector contents when converted to string. Example: '%2.2f'
%Example: setguistring([1, 2.23, 3, 4.56], textfieldHandle, 'String',
%'%2.2f')

%initialise strings
str='';

struct=getappdata(gethandle,'gaitData');
vector=struct.(gaitvar);
vector=vector.*convFac;
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
set(sethandle,property,str);
