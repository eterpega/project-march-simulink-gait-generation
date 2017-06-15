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

% Last Modified by GUIDE v2.5 14-Jun-2017 20:05:07

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

x=str2num(get(handles.KeyEventPhaseHip,'String'));
y=str2num(get(handles.KeyEventQHip,'String'));
    for n=1:length(x);
    h(n) = impoint(handles.GraphQHip,x(n), y(n))
    %setPositionContraintFcn(h(n)
    end


    

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



function KeyEventPhaseHip_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of KeyEventPhaseHip as text
%        str2double(get(hObject,'String')) returns contents of KeyEventPhaseHip as a double


% --- Executes during object creation, after setting all properties.
function KeyEventPhaseHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventPhaseHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




function KeyEventQHip_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventQHip as text
%        str2double(get(hObject,'String')) returns contents of KeyEventQHip as a double


% --- Executes during object creation, after setting all properties.
function KeyEventQHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function KeyEventdQHip_Callback(hObject, eventdata, handles)
% hObject    handle to KeyEventdQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KeyEventdQHip as text
%        str2double(get(hObject,'String')) returns contents of KeyEventdQHip as a double


% --- Executes during object creation, after setting all properties.
function KeyEventdQHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KeyEventdQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function GraphQHip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to GraphQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate GraphQHip



% --- Executes on mouse press over axes background.
function GraphQHip_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to GraphQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function GraphQHip_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to GraphQHip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
