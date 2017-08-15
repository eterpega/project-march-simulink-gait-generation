function [] = set_gui_string(gethandle, gaitvar, sethandle, property, format, convFac)
%gethandle: handle of graph from whick gaitData is read.
%gaitData is a struct containing phase, y, dy
%   phase is in percent, from 0 to 100
%   y represent the value on the y axis
%   dy represents the derivative value at the point [phase, y]
%gaitvar: keyEvent variable (phase, y or dy) that is taken from gaitData.
%vector of data to convert to string with nice format
%sethandle: handle of object to write to. Usually a text field.
%property: property of sethandle object that is edited
%format: format of vector contents when converted to string. Example: '%2.2f'

%set_gui_string(handles.graphQKnee,'y',handles.keyEventQKnee,'String', format, 180/pi);
%gets 'y' data from QKnee graph and writes it to the 'String' property of the Y(QKnee) text field
%after formatting it to format ('%2.2f') and applying a 180/pi conversion
%factor (rad to deg)

%initialise strings
str='';

%Get gaitData
struct=getappdata(gethandle,'gaitData');
%From gaitData struct get the gaitvar field
vector=struct.(gaitvar);
%Apply conversion factor
vector=vector.*convFac;
%write coordinates to string format
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
