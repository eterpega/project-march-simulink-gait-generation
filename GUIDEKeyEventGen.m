%This is the GUI is used for designing gaits of bipedal axoskeleton with 4
%DOGs namely, LKFE,RKFE,LHFE,RHFE.
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

% Last Modified by GUIDE v2.5 17-Jul-2017 15:54:24

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

%Choose default command line output for GUIDEKeyEventGen

%Set pwd to dir of this script and then add pwd to path
%makes sure the pwd is always the one containing this script to avoid
%errors with wrong paths
[PATHSTR,~,~] = fileparts(mfilename('fullpath'));
cd(PATHSTR);
addpath(genpath(fullfile(pwd)));

%initializes the GUI by setting predefined points on the graphs and in the
%text edit fields.
init(hObject, eventdata, handles, varargin);

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

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_gait_data('knee', handles);
draw_points('knee', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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

update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventPhaseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventPhaseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventX_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function keyEventdYX_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_gait_data('x', handles);
draw_points('x', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventdYX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keyEventdQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to keyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

update_gait_data('knee', handles);
draw_points('knee', eventdata, handles);
selected=getappdata(handles.SelectionList,'selected');
compute_splines(handles,selected);

% --- Executes during object creation, after setting all properties.
function keyEventdQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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
[filename, pathname] = uigetfile('gait-data/KeyEventData/*.mat','Load Key Event data');
set(handles.keyEventFileName,'String',filename);
keyEventData  =	load(strcat(pathname,filename));
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
global stepTime gaitType
stepTime=keyEventData.stepTime;

if isfield(keyEventData,'gaitType')
    gaitType=keyEventData.gaitType;
else
    gaitType='Discontinuous';
    warndlg('gaitType not yet defined in the KeyEventData file you just loaded. Please save the file again to append the gaitType')
end


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

%Set stepTime in GUI
set(handles.stepTime,'String',num2str(stepTime));

%Set gaitType in GUI
contents = cellstr(get(handles.GaitTypeList,'String'));
gaitTypeIndex=find(~cellfun(@isempty,strfind(contents,gaitType)));
set(handles.GaitTypeList,'Value',gaitTypeIndex);

%Set parameterSelection in GUI
if selected==[0,1,1,0]
    set(handles.SelectionList,'Value',1)
elseif selected==[1,1,0,0]
    set(handles.SelectionList,'Value',2)
elseif selected==[0,0,1,1]
    set(handles.SelectionList,'Value',3)
end

%Determine selected parameters from selection list in GUI
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
global stepTime gaitType

%Get gait data
kneemat = get_gait_data(handles,'knee');
hipmat  = get_gait_data(handles,'hip');
xmat    = get_gait_data(handles,'x');
ymat    = get_gait_data(handles,'y');

%tranform from matrix to struct as these are easier to save with save
%function 
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

%find path of location where user wants to save file
[FileName, PATHNAME] = uiputfile('gait-data/KeyEventData/KeyEventData.mat','Save Key Event data');

%set pwd to location where user wants to save file
cd(PATHNAME);

%Save and append structs to .mat file
save(FileName,'hip');
save(FileName,'knee','-append');
save(FileName,'x','-append');
save(FileName,'y','-append');
save(FileName,'selected','-append');
save(FileName,'stepTime','-append');
save(FileName,'gaitType','-append');

%change back pwd to dir where this script is located
cd(currentDir);
set(handles.keyEventFileName,'String',FileName);


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

[selected,type1,type2,clearGraph1,clearGraph2]=param_selection(handles);
setappdata(handles.SelectionList,'selected',selected);

%clear graphs that are not editable
cla(clearGraph1); %clears graph with handle clearGraph (obtained from  param_selection function)
cla(clearGraph2);

%update gait data and draw points on the graph that is enabled
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

global angleKneeEndStopMinimum angleKneeEndStopMaximum angleHipEndStopMinimum angleHipEndStopMaximum gaitType

selected=getappdata(handles.SelectionList,'selected');
[gait,~,~,~,~,~,~,~,~,~,~,~,warningCount, messageWarning]=compute_splines(handles, selected);

%plot gait vectors for confirmation from User
fig=figure('position', [0, 0, 900, 500]);
subplot(2,1,1)
plot(gait.splineKnee(:,1),gait.splineKnee(:,2));
title('Knee Angles');
ylim([rad2deg(angleKneeEndStopMinimum) rad2deg(angleKneeEndStopMaximum)]);
xlabel('Phase %');
ylabel('Angle (deg)');
subplot(2,1,2)
plot(gait.splineHip(:,1),gait.splineHip(:,2));
title('Hip Angles');
ylim([rad2deg(angleHipEndStopMinimum) rad2deg(angleHipEndStopMaximum)]);

%Open question box for confirmation
str=['These are the vectors you will save to the Model Dictionary.\n',...
     'There is/are %i warning(s). \n'...
    ,cell2str(messageWarning)];

questionStr=sprintf(str, warningCount);
titleStr='Save gait data to Model DataDictionary';
choice=questdlg(questionStr,titleStr,'Yes','No','Yes');

%close figure with knee and hip angles
close(fig)

%save data to DataDictionary of simulink model
switch choice
    case 'Yes'
    dictionaryPath=strcat('..',filesep,'simulink-models',filesep,'Library'); %set datadictionary parent directory path
    dictionaryName='ModelDictionary.sldd'; %set datadictionary name
    fullDictionaryPath=[dictionaryPath filesep dictionaryName]; %construct full path name for data dictionary
    myDictionaryObj = Simulink.data.dictionary.open(fullDictionaryPath); %get datadictionary object
    sectionObj = getSection(myDictionaryObj,'Design Data'); %get datadictionary section object

    
    %set itemList for selection list below (gait types)
    itemList{1} = 'Continuous Gait';
    itemList{2} = 'Standing Up';
    itemList{3} = 'Sitting Down';
    itemList{4} = 'Stairs Up Right';
    itemList{5} = 'Stairs Up Left';
    itemList{6} = 'Stairs Down Right';
    itemList{7} = 'Stairs Down Left';
    itemList{8} = 'Manual';
    
    %'Rough Terrain';
    %Open dialog box for gait type selection
    [s,v] = listdlg('PromptString','Select the type of gait',...
                    'ListString',itemList,...
                    'SelectionMode','single',...
                    'ListSize',[300 300]);
    
     %check whether user uses right gaitType for the gait he wants to save
     if strcmpi(gaitType,'Continuous') && ~(s~=1|s~=8)
         msgbox('ERROR: You"re trying to save a non-continuous as a continuous one. This will result in an erroneous sample frequency!','Error: Save Gait','error')
         return
     elseif strcmpi(gaitType, 'Discontinuous') && s==1
         msgbox('ERROR: You"re trying to save a continuous as a non-continuous one. This will result in an erroneous sample frequency!','Error: Save Gait','error')
         return
     end        
                
     %give error if no selection made (v==0)
     if v==0git 
          msgbox('ERROR: No valid gait type selected','Error: Save Gait','error')
       
          
     elseif s==1 && v==1 %save continuous gait to MD

         [stepSwingLegHip, stepSwingLegKnee, stepStandLegHip, stepStandLegKnee]...
            =split_gait_vector(gait.splineHip(:,2),gait.splineKnee(:,2));

         kneeSwingEntryObj=getEntry(sectionObj,'stepSwingLegKnee');%get entryObj for knee
         hipSwingEntryObj=getEntry(sectionObj,'stepSwingLegHip');  %get entryObj for hip
         kneeStandEntryObj=getEntry(sectionObj,'stepStandLegKnee');%get entryObj for knee
         hipStandEntryObj=getEntry(sectionObj,'stepStandLegHip');  %get entryObj for hip
         
         %check whether entryObject exist
         if ~isempty(kneeSwingEntryObj) && ~isempty(hipSwingEntryObj)...
                 && ~isempty(kneeStandEntryObj) && ~isempty(hipStandEntryObj)
             
            [stepSwingLegHip, stepSwingLegKnee, stepStandLegHip, stepStandLegKnee]...
            =split_gait_vector(gait.splineHip(:,2), gait.splineKnee(:,2));
        
            setValue(hipSwingEntryObj,stepSwingLegHip);     %set entryObj for hip
            setValue(kneeSwingEntryObj,stepSwingLegKnee);   %set entryObj for knee            
            setValue(hipStandEntryObj,stepStandLegHip);     %set entryObj for hip
            setValue(kneeStandEntryObj,stepStandLegKnee);   %set entryObj for knee
            
            saveChanges(myDictionaryObj);                   %save all changes to the model data dictionary
         
         %give error if entryObjs are empty   
         elseif isempty(kneeSwingEntryObj) || isempty(hipSwingEntryObj)...
                 || isempty(kneeStandEntryObj) || isempty(hipStandEntryObj) 
            msgbox('ERROR: entries found in DataDictionary are not valid','Error: DD entries','error')
         end
         
     %save standUp vectors to MD
     elseif s==2 && v==1
        write_to_model_dictionary(myDictionaryObj, sectionObj, 'standUpKnee', 'standUpHip', gait);
         
     %save sitDown vectors to MD
     elseif s==3 && v==1
        write_to_model_dictionary(myDictionaryObj, sectionObj, 'sitDownKnee', 'sitDownHip', gait);
     
        %save stairsUpRight vectors to MD
       elseif s==4 && v==1
        write_to_model_dictionary(myDictionaryObj, sectionObj, 'stairsUpRightKnee', 'stairsUpRightHip', gait);

        %save stairsUpLeft vectors to MD
       elseif s==5 && v==1
          write_to_model_dictionary(myDictionaryObj, sectionObj, 'stairsUpLeftKnee', 'stairsUpLeftHip', gait);

        %save stairsDownRight vectors to MD
       elseif s==6 && v==1
           write_to_model_dictionary(myDictionaryObj, sectionObj, 'stairsDownRightKnee', 'stairsDownRightHip', gait);

        %save stairsDownLeft vectors to MD
      elseif s==7 && v==1
          write_to_model_dictionary(myDictionaryObj, sectionObj, 'stairsDownLeftKnee', 'stairsDownLeftHip', gait);
        
         %save vectors manually to user defined location
        elseif s==8 
            %get vector name from original KeyEventData.mat file
         vectorName=get(handles.keyEventFileName,'String');
         [FileName, PATHNAME] = uiputfile(vectorName,'Save Gait Vector Manually');
         kneeVect=gait.splineKnee(:,2);
         hipVect=gait.splineHip(:,2);
         save([PATHNAME,FileName(1:end-4),'_Knee',FileName(end-3:end)],'kneeVect');
         save([PATHNAME,FileName(1:end-4),'_Hip',FileName(end-3:end)],'hipVect');
         
        %roughTerrain
%       elseif s==8 && v==1
%           write_to_model_dictionary(myDictionaryObj, sectionObj, 'roughTerrainLeftKnee', 'roughTerrainLeftHip', gait);
     end
    case choice=='No'
end

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

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in detailplotbutton.
function detailplotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to detailplotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected=getappdata(handles.SelectionList,'selected');

%Draw detailed plots of gait
[~, phase, angleHip_deg,angleKnee_deg, x, y,...
angleHip_RPM, angleKnee_RPM, angleHip_rads2, angleKnee_rads2, time, samplePointAmount]...
= compute_splines(handles, selected);
detail_plots(phase, angleHip_deg, angleKnee_deg, x.x, y.y,...
angleHip_RPM, angleKnee_RPM, angleHip_rads2, angleKnee_rads2, time, samplePointAmount);


% --- Executes on selection change in GaitTypeList.
function GaitTypeList_Callback(hObject, eventdata, handles)
% hObject    handle to GaitTypeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gaitType
selected=getappdata(handles.SelectionList,'selected');
contents = cellstr(get(hObject,'String'));
gaitType=contents{get(hObject,'Value')};
compute_splines(handles, selected);


% --- Executes during object creation, after setting all properties.
function GaitTypeList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GaitTypeList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in halfStepsGen.
function halfStepsGen_Callback(hObject, eventdata, handles)
% hObject    handle to savegaitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%This script gets the standUp, stepStand and stepSwing vectors for Knee
%and Hip from the model dictionary. If the variables do not exist an error
%is given.
%Based on these vectors it constructs vectors for the start and stop half
%steps by truncating the normal gait vectors
%2 different vectors are needed depending on whether the leg is currently 
%a stance or swing leg.
%Finally the half step vectors are added to the Model Dictionary.
%If the variable do not exist yet they are added after confirmation has
%been given by the user

%To make this work the user needs to define the path to the model
%dictionary in the INITIALIZE section (top section of the script)

%% INITIALIZE

[PATHSTR,~,~] = fileparts(mfilename('fullpath'));
cd(PATHSTR);
%SET datadictionary parent directory path
dictionaryPath=strcat('..',filesep,'simulink-models',filesep,'Library');
%set datadictionary name
dictionaryName='ModelDictionary.sldd'; 
%construct full path name for data dictionary
fullDictionaryPath=[dictionaryPath filesep dictionaryName]; 
%get datadictionary object
myDictionaryObj = Simulink.data.dictionary.open(fullDictionaryPath);
%get datadictionary section object
sectionObj = getSection(myDictionaryObj,'Design Data'); 

kneeSwingEntryObj   = getEntry(sectionObj,'stepSwingLegKnee'); %get entryObj for knee walk
hipSwingEntryObj    = getEntry(sectionObj,'stepSwingLegHip');   %get entryObj for hip walk
kneeStandEntryObj   = getEntry(sectionObj,'stepStandLegKnee'); %get entryObj for knee walk
hipStandEntryObj    = getEntry(sectionObj,'stepStandLegHip');   %get entryObj for hip walk
kneeStandUpEntryObj = getEntry(sectionObj,'standUpKnee');    %get entryObj for knee stand up
hipStandUpEntryObj  = getEntry(sectionObj,'standUpHip');      %get entryObj for hip stand up
kneeSitDownEntryObj = getEntry(sectionObj,'sitDownKnee');    %get entryObj for knee sit down
hipSitDownEntryObj  = getEntry(sectionObj,'sitDownHip');      %get entryObj for hip sit down
kneeInitSitDownEntryObj  = getEntry(sectionObj,'initializeSitDownKnee');      %get entryObj for knee init sit down
hipInitSitDownEntryObj  = getEntry(sectionObj,'initializeSitDownHip');      %get entryObj for hip init sit down
kneeInitStandUpEntryObj  = getEntry(sectionObj,'initializeStandUpKnee');      %get entryObj for knee init sit down
hipInitStandUpEntryObj  = getEntry(sectionObj,'initializeStandUpHip');      %get entryObj for hip init sit down

     if ~isempty(kneeSwingEntryObj) && ~isempty(hipSwingEntryObj)...
             && ~isempty(kneeStandEntryObj) && ~isempty(hipStandEntryObj)...
             && ~isempty(kneeStandUpEntryObj) && ~isempty(hipStandUpEntryObj)...
             && ~isempty(kneeSitDownEntryObj) && ~isempty(hipSitDownEntryObj)...
             && ~isempty(kneeInitSitDownEntryObj) && ~isempty(hipInitSitDownEntryObj)...
             && ~isempty(kneeInitStandUpEntryObj) && ~isempty(hipInitStandUpEntryObj)

         %Get Values from model dictionnary
        stepSwingLegHip     = getValue(hipSwingEntryObj);     
        stepSwingLegKnee    = getValue(kneeSwingEntryObj);   
        stepStandLegHip     = getValue(hipStandEntryObj); 
        stepStandLegKnee    = getValue(kneeStandEntryObj);
        standUpKnee         = getValue(kneeStandUpEntryObj);
        standUpHip          = getValue(hipStandUpEntryObj);
        sitDownKnee         = getValue(kneeSitDownEntryObj);
        sitDownHip          = getValue(hipSitDownEntryObj);
        initializeSitDownKnee   = getValue(kneeInitSitDownEntryObj);
        initializeSitDownHip    = getValue(hipInitSitDownEntryObj);
        initializeStandUpKnee   = getValue(kneeInitStandUpEntryObj);
        initializeStandUpHip    = getValue(hipInitStandUpEntryObj);

     %give error if entryObjs are empty   
     elseif isempty(kneeSwingEntryObj) || isempty(hipSwingEntryObj)...
             || isempty(kneeStandEntryObj) || isempty(hipStandEntryObj)...
             || isempty(kneeSitDownEntryObj) || isempty(hipSitDownEntryObj)...
             || isempty(kneeInitSitDownEntryObj) || isempty(hipInitSitDownEntryObj)...
             || isempty(kneeInitStandUpEntryObj) || isempty(hipInitStandUpEntryObj)
        msgbox('ERROR: entries found in Model Dictionary are not valid','Error: Model Dictionary entries','error')
        return
     end
     
%% RUN half_steps_generator_func
[startStandHalfStepHip,startStandHalfStepKnee,...
    startSwingHalfStepHip,startSwingHalfStepKnee,...
    stopHalfStepFromSwingKnee,stopHalfStepFromSwingHip,...
    stopHalfStepFromStandKnee,stopHalfStepFromStandHip]...
    = half_steps_generator_func(stepSwingLegHip, stepSwingLegKnee,...
    stepStandLegHip,stepStandLegKnee, standUpKnee, standUpHip, sitDownKnee,...
    sitDownHip,initializeSitDownKnee, initializeSitDownHip,...
    initializeStandUpKnee, initializeStandUpHip);

%% USER CHECK IF VECTORS ARE CONTINUOUS

%ask user confirmation if all gaits seem contiuous
questionStr=['Are all the gait vectors continuous?'];
    titleStr='Check if the gait vectors are continuous';
    choice1=questdlg(questionStr,titleStr,'Yes','No','Manual Saving','No');
        
switch choice1
    case 'Manual Saving'
        [FileName, PATHNAME] = uiputfile('HalfSteps','Save Half Steps Vectors Manually');
        fileLoc=[PATHNAME,FileName];
        save(fileLoc,'startStandHalfStepHip');
        save(fileLoc,'startStandHalfStepKnee','-append');
        save(fileLoc,'startSwingHalfStepHip','-append');
        save(fileLoc,'startSwingHalfStepKnee','-append');
        save(fileLoc,'stopHalfStepFromSwingKnee','-append');
        save(fileLoc,'stopHalfStepFromSwingHip','-append');
        save(fileLoc,'stopHalfStepFromStandKnee','-append');
        save(fileLoc,'stopHalfStepFromStandHip','-append');
        
    case 'No'
        return
        
    case 'Yes'
%% SAVE HALF STEPS TO MODEL DICTIONARY

%Define variable names
varNameStartStandHalfStepHip    = 'halfStepStandStartHip';
varNameStartStandHalfStepKnee   = 'halfStepStandStartKnee';
varNameStartSwingHalfStepHip    = 'halfStepSwingStartHip';
varNameStartSwingHalfStepKnee   = 'halfStepSwingStartKnee';
varNameStopStepFromSwingKnee    = 'halfStepStopFromSwingKnee';
varNameStopStepFromSwingHip     = 'halfStepStopFromSwingHip';
varNameStopStepFromStandKnee    = 'halfStepStopFromStandKnee';
varNameStopStepFromStandHip     = 'halfStepStopFromStandHip';

         
     if exist(sectionObj, varNameStartStandHalfStepHip) && exist(sectionObj, varNameStartStandHalfStepKnee)...
             && exist(sectionObj, varNameStartSwingHalfStepHip) && exist(sectionObj, varNameStartSwingHalfStepKnee)...
             && exist(sectionObj, varNameStopStepFromSwingKnee) && exist(sectionObj, varNameStopStepFromSwingHip)...
             && exist(sectionObj, varNameStopStepFromStandKnee) && exist(sectionObj, varNameStopStepFromStandHip)
        
        %Get entry object from data dictionary 
        startStandHalfStepHipEntryObj   = getEntry(sectionObj,varNameStartStandHalfStepHip);
        startStandHalfStepKneeEntryObj  = getEntry(sectionObj,varNameStartStandHalfStepKnee);
        startSwingHalfStepHipEntryObj   = getEntry(sectionObj,varNameStartSwingHalfStepHip);
        startSwingHalfStepKneeEntryObj  = getEntry(sectionObj,varNameStartSwingHalfStepKnee);
        stopStepFromSwingKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromSwingKnee);
        stopStepFromSwingHipEntryObj    = getEntry(sectionObj,varNameStopStepFromSwingHip);
        stopStepFromStandKneeEntryObj   = getEntry(sectionObj,varNameStopStepFromStandKnee);
        stopStepFromStandHipEntryObj    = getEntry(sectionObj,varNameStopStepFromStandHip);

        %Set Values in Data Dictionary
        setValue(startStandHalfStepHipEntryObj, startStandHalfStepHip);
        setValue(startStandHalfStepKneeEntryObj, startStandHalfStepKnee);
        setValue(startSwingHalfStepHipEntryObj, startSwingHalfStepHip);
        setValue(startSwingHalfStepKneeEntryObj, startSwingHalfStepKnee);
        setValue(stopStepFromSwingKneeEntryObj ,stopHalfStepFromSwingKnee);
        setValue(stopStepFromSwingHipEntryObj  ,stopHalfStepFromSwingHip);
        setValue(stopStepFromStandKneeEntryObj ,stopHalfStepFromStandKnee);
        setValue(stopStepFromStandHipEntryObj  ,stopHalfStepFromStandHip);
 
        saveChanges(myDictionaryObj);

      elseif ~exist(sectionObj, varNameStartStandHalfStepHip) || ~exist(sectionObj, varNameStartStandHalfStepKnee)...
            || ~exist(sectionObj, varNameStartSwingHalfStepHip) || ~exist(sectionObj, varNameStartSwingHalfStepKnee)...
            || ~exist(sectionObj, varNameStopStepFromSwingKnee) || ~exist(sectionObj, varNameStopStepFromSwingHip)...
            || ~exist(sectionObj, varNameStopStepFromStandKnee) || ~exist(sectionObj, varNameStopStepFromStandHip)
        
        %Open question box for confirmation
        questionStr=['WARNING: Some or all of the half step vector Entries ',...
            'do not yet exist in Model Dictionary. Are you sure you want to add them?'];
        titleStr='Add half steps to Model DataDictionary';
        choice=questdlg(questionStr,titleStr,'Yes','No','No');

        switch choice
            case 'No';
                return
                
            case 'Yes';
                %Add Entries in Data Dictionary
                startStandHalfStepHipEntryObj   = addEntry(sectionObj,varNameStartStandHalfStepHip, startStandHalfStepHip);
                startStandHalfStepKneeEntryObj  = addEntry(sectionObj,varNameStartStandHalfStepKnee, startStandHalfStepKnee);
                startSwingHalfStepHipEntryObj   = addEntry(sectionObj,varNameStartSwingHalfStepHip, startSwingHalfStepHip);
                startSwingHalfStepKneeEntryObj  = addEntry(sectionObj,varNameStartSwingHalfStepKnee, startSwingHalfStepKnee);
                stopStepFromSwingKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromSwingKnee, stopHalfStepFromSwingKnee);
                stopStepFromSwingHipEntryObj    = addEntry(sectionObj,varNameStopStepFromSwingHip, stopHalfStepFromSwingHip);
                stopStepFromStandKneeEntryObj   = addEntry(sectionObj,varNameStopStepFromStandKnee, stopHalfStepFromStandKnee);
                stopStepFromStandHipEntryObj    = addEntry(sectionObj,varNameStopStepFromStandHip, stopHalfStepFromStandHip);

                saveChanges(myDictionaryObj);
        end     
     end
end
