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

% Last Modified by GUIDE v2.5 21-Jun-2017 09:34:14

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

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Default values at startup
%knee
initPhaseKnee   =	[0, 18, 45, 78];
initQKnee       =	[0, 15, 2, 60]/180*pi;
initdQKnee      =	[0,0, 0 ,0];
%xFoot
initPhaseX      =   [0, 18, 45, 62];
initYX          =   [0.15, 0.0, -0.1, -0.25];
initdYX         =   [0, -0.0035, -0.0035, 0];

%Define graph limit values GUI
kneeXLim=[0 100];
kneeYLim=[0 120];
xXLim=[0 100];
xYLim=[-10 60];

%Write default values to GUI
format='%2.2f';
set_gui_string(initPhaseKnee,handles.keyEventPhaseKnee,'String',format);
set_gui_string(initQKnee,handles.keyEventQKnee,'String',format);
set_gui_string(initdQKnee,handles.keyEventdQKnee,'String',format);
set_gui_string(initPhaseX,handles.keyEventPhaseX,'String',format);
set_gui_string(initYX,handles.keyEventX,'String',format);
set_gui_string(initdYX,handles.keyEventdYX,'String',format);

%Set Graph Axis limits
set(handles.graphQKnee,'XLim',kneeXLim);
set(handles.graphQKnee,'YLim',kneeYLim);
set(handles.graphX,'XLim',xXLim);
set(handles.graphX,'YLim',xYLim);

%Draw Graphs at initialization
%DrawPoints(hObject, eventdata, handles);
draw_points(handles.graphQKnee, eventdata, handles);
draw_points(handles.graphX, eventdata, handles);

% Update handles structure
guidata(hObject, handles);
[angleHip, angleKnee, x, y, foot] = drawsplineGUI(handles);
%[phaseEvent1, phaseEvent2, selected] = get_gait_data(handles)

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

% Hints: get(hObject,'String') returns contents of keyEventPhaseKnee as text
%        str2double(get(hObject,'String')) returns contents of keyEventPhaseKnee as a double
draw_points(handles.graphQKnee, eventdata, handles);



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
draw_points(handles.graphQKnee, eventdata, handles);

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
draw_points(handles.graphX, eventdata, handles);

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
draw_points(handles.graphX, eventdata, handles);

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
draw_points(handles.graphX, eventdata, handles);

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
draw_points(handles.graphQKnee, eventdata, handles);

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
