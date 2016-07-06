function varargout = AoIConfig(varargin)
% AOICONFIG MATLAB code for AoIConfig.fig
%      AOICONFIG, by itself, creates a new AOICONFIG or raises the existing
%      singleton*.
%
%      H = AOICONFIG returns the handle to a new AOICONFIG or the handle to
%      the existing singleton*.
%
%      AOICONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AOICONFIG.M with the given input arguments.
%
%      AOICONFIG('Property','Value',...) creates a new AOICONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AoIConfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AoIConfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AoIConfig

% Last Modified by GUIDE v2.5 09-May-2016 17:44:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AoIConfig_OpeningFcn, ...
                   'gui_OutputFcn',  @AoIConfig_OutputFcn, ...
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


% --- Executes just before AoIConfig is made visible.
function AoIConfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AoIConfig (see VARARGIN)

% Choose default command line output for AoIConfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AoIConfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AoIConfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in defineAOI.
function defineAOI_Callback(hObject, eventdata, handles)
% hObject    handle to defineAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in getAOI.
function getAOI_Callback(hObject, eventdata, handles)
% hObject    handle to getAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clearAOI.
function clearAOI_Callback(hObject, eventdata, handles)
% hObject    handle to clearAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function percPot_Callback(hObject, eventdata, handles)
% hObject    handle to percPot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percPot as text
%        str2double(get(hObject,'String')) returns contents of percPot as a double


% --- Executes during object creation, after setting all properties.
function percPot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to percPot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in modeMenu.
function modeMenu_Callback(hObject, eventdata, handles)
% hObject    handle to modeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns modeMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from modeMenu


% --- Executes during object creation, after setting all properties.
function modeMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to modeMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in selectAOIMenu.
function selectAOIMenu_Callback(hObject, eventdata, handles)
% hObject    handle to selectAOIMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns selectAOIMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from selectAOIMenu


% --- Executes during object creation, after setting all properties.
function selectAOIMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selectAOIMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enableAOI.
function enableAOI_Callback(hObject, eventdata, handles)
% hObject    handle to enableAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of enableAOI


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
