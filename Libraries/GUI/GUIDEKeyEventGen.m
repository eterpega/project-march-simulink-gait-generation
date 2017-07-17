function varargout = GUIDEKeyEventGen(varargin)
% GUIDEKEYEVENTGEN MATLAB code for GUIDEKeyEventGen.fig
%      GUIDEKEYEVENTGEN, by itself, creates a new GUIDEKEYEVENTGEN or raises the existing
%      singleton*.
%
%      H = GUIDEKEYEVENTGEN returns the handle to a new GUIDEKEYEVENTGEN or the handle to
%      the existing singleton*.
%
%      GUIDEKEYEVENTGEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDEKEYEVENTGEN.M with the given input arguments.
%
%      GUIDEKEYEVENTGEN('Property','Value',...) creates a new GUIDEKEYEVENTGEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIDEKeyEventGen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIDEKeyEventGen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIDEKeyEventGen

% Last Modified by GUIDE v2.5 09-Jul-2017 20:46:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIDEKeyEventGen_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIDEKeyEventGen_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUIDEKeyEventGen is made visible.
function GUIDEKeyEventGen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIDEKeyEventGen (see VARARGIN)

% Choose default command line output for GUIDEKeyEventGen

init_GUI(hObject, eventdata, handles, varargin)

% UIWAIT makes GUIDEKeyEventGen wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = GUIDEKeyEventGen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function keyEventPhaseKnee_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('knee', handles);
draw_points('knee', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventPhaseKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyEventQKnee as text
%        str2double(get(hObject,'String')) returns contents of keyEventQKnee as a double
update_gait_data('knee', handles);
draw_points('knee', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function graphQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate graphQKnee



% --- Executes on mouse press over axes background.
function graphQKnee_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to graphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);

% --- Executes during object deletion, before destroying properties.
function graphQKnee_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to graphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function keyEventPhaseX_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyEventPhaseX as text
%        str2double(get(hObject,'String')) returns contents of keyEventPhaseX as a double
update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventPhaseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventX_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyEventX as text
%        str2double(get(hObject,'String')) returns contents of keyEventX as a double
update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventdYX_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyEventdYX as text
%        str2double(get(hObject,'String')) returns contents of keyEventdYX as a double
update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventdYX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventdQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keyEventdQKnee as text
%        str2double(get(hObject,'String')) returns contents of keyEventdQKnee as a double
update_gait_data('knee', handles);
draw_points('knee', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventdQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on key press with focus on keyEventPhaseKnee and none of its controls.
function keyEventPhaseKnee_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseKnee (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RunSimpushbutton.
function RunSimpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RunSimpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%run_simulation(gcf)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RunSimpushbutton.
function RunSimpushbutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RunSimpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in LoadKeyEventsButton.
function LoadKeyEventsButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadKeyEventsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = uigetfile('*.mat','Load Key Event data');
keyEventData  =	load(filename);
%knee [rad]
knee=keyEventData.knee;
%hip [rad]
hip=keyEventData.hip;
%xFoot [meters]
x=keyEventData.x;
%yFoot [meters]
y=keyEventData.y;
%Selected vector
selected=keyEventData.selected;
%Step frequency
global stepTime
stepTime=keyEventData.stepTime;

%Clear all plots
cla(handles.graphQHip);
cla(handles.graphQKnee);
cla(handles.graphX);
cla(handles.graphY);

%Write data to UserData field of respective graph
setappdata(handles.graphQKnee,'gaitData',knee);
setappdata(handles.graphQHip,'gaitData',hip);
setappdata(handles.graphX,'gaitData',x);
setappdata(handles.graphY,'gaitData',y);

%Write converted init values to GUI
format='%2.2f';
dyformat='%2.4f';
%Knee
set_gui_string(handles.graphQKnee,'phase',handles.keyEventPhaseKnee,'String', format, 1);
set_gui_string(handles.graphQKnee,'y',handles.keyEventQKnee,'String', format, 180/pi);
set_gui_string(handles.graphQKnee,'dy',handles.keyEventdQKnee,'String', dyformat, 180/pi);
%Hip
set_gui_string(handles.graphQHip,'phase',handles.keyEventPhaseHip,'String', format, 1);
set_gui_string(handles.graphQHip,'y',handles.keyEventQHip,'String', format, 180/pi);
set_gui_string(handles.graphQHip,'dy',handles.keyEventdQHip,'String', dyformat, 180/pi);
%X
set_gui_string(handles.graphX,'phase',handles.keyEventPhaseX,'String', format, 1);
set_gui_string(handles.graphX,'y',handles.keyEventX,'String', format, 1);
set_gui_string(handles.graphX,'dy',handles.keyEventdYX,'String',dyformat, 1);
%Y
set_gui_string(handles.graphY,'phase',handles.keyEventPhaseY,'String', format, 1);
set_gui_string(handles.graphY,'y',handles.keyEventY,'String', format, 1);
set_gui_string(handles.graphY,'dy',handles.keyEventdYY,'String',dyformat, 1);
%stepTime
set(handles.stepTime,'String',num2str(stepTime));

%Determine selected parameters from selection list in GUI
%selected=param_selection(handles);
setappdata(handles.SelectionList,'selected',selected);

[selected,type1,type2] = param_selection(handles);
%Draw Graphs at initialization
%DrawPoints(hObject, eventdata, handles);
init_points(type1, eventdata, handles);
init_points(type2, eventdata, handles);

%Draw the splines in the GUI
compute_splines(handles,selected);

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in SaveKeyEventsButton.
function SaveKeyEventsButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveKeyEventsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stepTime

%Get gait data
kneemat = get_gait_data(handles,'knee');
hipmat  = get_gait_data(handles,'hip');
xmat    = get_gait_data(handles,'x');
ymat    = get_gait_data(handles,'y');

%tranform from mat to struct
hip.phase=hipmat(1,:);
hip.y=hipmat(2,:);
hip.dy=hipmat(3,:);

knee.phase=kneemat(1,:);
knee.y=kneemat(2,:);
knee.dy=kneemat(3,:);

x.phase=xmat(1,:);
x.y=xmat(2,:);
x.dy=xmat(3,:);

y.phase=ymat(1,:);
y.y=ymat(2,:);
y.dy=ymat(3,:);

%get 'selected' vector
selected=getappdata(handles.SelectionList,'selected');

%Define filename
currentDir=pwd;
[FileName, PATHNAME] = uiputfile('KeyEventData.mat','Save Key Event data');
cd(PATHNAME);
%Save and append struct to .mat file
save(FileName,'hip');
save(FileName,'knee','-append');
save(FileName,'x','-append');
save(FileName,'y','-append');
save(FileName,'selected','-append');
save(FileName,'stepTime','-append');
cd(currentDir);


% --- Executes on button press in AnimationButton.
function AnimationButton_Callback(hObject, eventdata, handles)
% hObject    handle to AnimationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected=getappdata(handles.SelectionList,'selected');
animation_gui(handles, selected);

% --- Executes on selection change in SelectionList.
function SelectionList_Callback(hObject, eventdata, handles)
% hObject    handle to SelectionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SelectionList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SelectionList
[selected,type1,type2,clearGraph1,clearGraph2]=param_selection(handles);
setappdata(handles.SelectionList,'selected',selected);

cla(clearGraph1)
cla(clearGraph2)

update_gait_data(type1, handles);
draw_points(type1, eventdata, handles);

update_gait_data(type2, handles);
draw_points(type2, eventdata, handles);

selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);


% Update handles structure
guidata(handles.SelectionList, handles);


% --- Executes during object creation, after setting all properties.
function SelectionList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SelectionList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventdYY_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdYY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('y', handles);
draw_points('y', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventdYY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdYY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventY_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('y', handles);
draw_points('y', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventPhaseY_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('y', handles);
draw_points('y', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventPhaseY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventdQHip_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('hip', handles);
draw_points('hip', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventdQHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventQHip_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('hip', handles);
draw_points('hip', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventQHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventPhaseHip_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
update_gait_data('hip', handles);
draw_points('hip', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function keyEventPhaseHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in savegaitbutton.
function savegaitbutton_Callback(hObject, eventdata, handles)
% hObject    handle to savegaitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected=getappdata(handles.SelectionList,'selected');
%currDir=pwd;
[FileName, PathName] = uiputfile('GaitData.mat','Save Gait Data');
gait=compute_splines(handles, selected);
%cd(PathName);
fileLoc=strcat(PathName, FileName)
save(fileLoc,'-struct','gait','splineHip','splineKnee');
%cd(currDir);

function stepTime_Callback(hObject, eventdata, handles)
% hObject    handle to stepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get 'stepTime' value
global stepTime
selected=getappdata(handles.SelectionList,'selected');
stepTime=str2num(get(handles.stepTime,'String'));
compute_splines(handles, selected);

% --- Executes during object creation, after setting all properties.
function stepTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to stepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stepTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in detailplotbutton.
function detailplotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to detailplotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected=getappdata(handles.SelectionList,'selected');
[~, phase, angleHip_deg,angleKnee_deg, x, y,...
angleHip_RPM, angleKnee_RPM, angleHip_rads2, angleKnee_rads2, time, samplePointAmount]...
= compute_splines(handles, selected);
detail_plots(phase, angleHip_deg, angleKnee_deg, x.x, y.y,...
angleHip_RPM, angleKnee_RPM, angleHip_rads2, angleKnee_rads2, time, samplePointAmount);
