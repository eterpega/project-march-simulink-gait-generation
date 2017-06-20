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

% Last Modified by GUIDE v2.5 20-Jun-2017 17:13:59

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

%myfile = '../../Complete_Model/SplineGeneratorTest';
%cd('../../Complete_Model')
%load_system('SplineGeneratorTest')
%cd('../Libraries/GUI')
%mh=get_param(SplineGeneratorTest,'handle')

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Default values at startup
InitPhaseKnee   =	[0.0, 20.8, 45.4, 66.2, 84.6, 100.0];
InitQKnee       =	[0.0, 31.1, 18.3, 37.0, 60.9, 30.0];
InitdQKnee      =	[0, 1, -1, 0, 1, 0];
InitPhaseX      =   [0.0, 17.1, 38.9, 71.8, 100.0];
InitYX          =   [18.3, 2.1, -10.0, 1.6 , 6.5];
InitdYX         =   [0, 1, -1, 0, 1];

%Define graph limit values GUI
KneeXLim=[0 100];
KneeYLim=[0 120];
XXLim=[0 100];
XYLim=[-10 60];

%Write default values to GUI
setguistring(InitPhaseKnee,handles.KeyEventPhaseKnee,'String','%2.1f');
setguistring(InitQKnee,handles.KeyEventQKnee,'String','%2.1f');
setguistring(InitdQKnee,handles.KeyEventdQKnee,'String','%2.1f');
setguistring(InitPhaseX,handles.KeyEventPhaseX,'String','%2.1f');
setguistring(InitYX,handles.KeyEventX,'String','%2.1f');
setguistring(InitdYX,handles.KeyEventdYX,'String','%2.1f');

%Set Graph Axis limits
set(handles.GraphQKnee,'XLim',KneeXLim);
set(handles.GraphQKnee,'YLim',KneeYLim);
set(handles.GraphX,'XLim',XXLim);
set(handles.GraphX,'YLim',XYLim);

%Draw Graphs at initialization
%DrawPoints(hObject, eventdata, handles);
DrawPoints(handles.GraphQKnee, eventdata, handles);
DrawPoints(handles.GraphX, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

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

function KeyEventPhaseKnee_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventPhaseKnee as text
%        str2double(get(hObject,'String')) returns contents of KeyEventPhaseKnee as a double
DrawPoints(handles.GraphQKnee, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function KeyEventPhaseKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function KeyEventQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventQKnee as text
%        str2double(get(hObject,'String')) returns contents of KeyEventQKnee as a double
DrawPoints(handles.GraphQKnee, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function KeyEventQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function GraphQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate GraphQKnee



% --- Executes on mouse press over axes background.
function GraphQKnee_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to GraphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);



% --- Executes during object deletion, before destroying properties.
function GraphQKnee_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to GraphQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function KeyEventPhaseX_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventPhaseX as text
%        str2double(get(hObject,'String')) returns contents of KeyEventPhaseX as a double
DrawPoints(handles.GraphX, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function KeyEventPhaseX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KeyEventX_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventX as text
%        str2double(get(hObject,'String')) returns contents of KeyEventX as a double
DrawPoints(handles.GraphX, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function KeyEventX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function KeyEventdYX_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventdYX as text
%        str2double(get(hObject,'String')) returns contents of KeyEventdYX as a double
DrawPoints(handles.GraphX, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function KeyEventdYX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventdYX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function KeyEventdQKnee_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventdQKnee as text
%        str2double(get(hObject,'String')) returns contents of KeyEventdQKnee as a double
DrawPoints(handles.GraphQKnee, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function KeyEventdQKnee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventdQKnee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on KeyEventPhaseKnee and none of its controls.
function KeyEventPhaseKnee_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseKnee (see GCBO)
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
RunSimulation(gcf)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over RunSimpushbutton.
function RunSimpushbutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to RunSimpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
