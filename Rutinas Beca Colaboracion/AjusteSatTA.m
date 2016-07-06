function varargout = AjusteSatTA(varargin)
% AJUSTESATTA MATLAB code for AjusteSatTA.fig
%      AJUSTESATTA, by itself, creates a new AJUSTESATTA or raises the existing
%      singleton*.
%
%      H = AJUSTESATTA returns the handle to a new AJUSTESATTA or the handle to
%      the existing singleton*.
%
%      AJUSTESATTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AJUSTESATTA.M with the given input arguments.
%
%      AJUSTESATTA('Property','Value',...) creates a new AJUSTESATTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AjusteSatTA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AjusteSatTA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AjusteSatTA

% Last Modified by GUIDE v2.5 17-Mar-2016 13:27:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AjusteSatTA_OpeningFcn, ...
                   'gui_OutputFcn',  @AjusteSatTA_OutputFcn, ...
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

% --- Executes just before AjusteSatTA is made visible.
function AjusteSatTA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AjusteSatTA (see VARARGIN)

% Choose default command line output for AjusteSatTA
handles.output = hObject;

%¡Cuidado! ¡Se desactivan todos los warnings!
warning('off', 'all')

%Get the fix text "Potency in AOI:" in a variable
handles.fixtextMeasAOIPot = 'Potency in AOI: ';
handles.fixtextsatPixels = 'Saturated pixels (% of AOI): ';

handles.AOIType = 'auto';

handles.Tpix = 30;

handles.n = 1;

%Flag indicando que el eje inicialmente está en pixeles
handles.axisMicrons = 0;

%Flag indicando que no se está definiendo un AOI
handles.definingAOI = 0;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = AjusteSatTA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%
% ---------- CreateFcn start ----------
%

% --- Executes during object creation, after setting all properties.
function CameraAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

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
handles.percPotency = str2double(get(hObject,'String'));

%%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function cameraAxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: place code in OpeningFcn to populate cameraAxes

% --- Executes during object creation, after setting all properties.
function cameraControlState_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cameraControlState (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function apertureTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to apertureTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function measPotButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to measPotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.measPotState = get(hObject,'Value');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function satControlButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to satControlButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.satControlState = get(hObject,'Value');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function noiseControlButton_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noiseControlButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.backNoiseState = get(hObject,'Value');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function potUnitMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to potUnitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
contents = cellstr(get(hObject,'String'));
handles.potUnit = contents{get(hObject,'Value')};
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- CreateFcn end ----------
%

%
% ---------- Camera control panel start ----------
%

% --- Executes on button press in connectCamera.
function connectCamera_Callback(hObject, eventdata, handles)
% hObject    handle to connectCamera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto de "State" a "Busy...", deshabilitar todos los elementos
%del gui hasta el final del callback
set(handles.cameraControlState,'String', 'Busy...'); drawnow;
disableAll(handles);
set(handles.connectCamera,'Enable', 'on');

%Desconectar y eliminar todos los objetos de adquisición de imágenes
imaqreset;

%Intentar crear el objeto de video para la camara gige con el formato
%Mono12. Error si no es posible.
try
     handles.vid = videoinput('gige',1,'Mono12');
 catch exception
     h = msgbox('Error. No GigE Vision cameras could be found.','No Camera found','error');
end

%Si se crea el objeto de video correctamente
if (~(exist('exception')))
    
    %Reemplazar el texto en el botón por "Reconnect camera" tras la primera
    %pulsación
    string = get(hObject, 'String');
    if(strcmp(string,'Connect Camera'))
        set(hObject,'String', 'Reconnect Camera');
    end
    
    %Crear el objeto "source"
    handles.src = getselectedsource(handles.vid);
    handles.infosrc = get(handles.src);
    
    %Configurar los objectos de video y "source" y obtener el TA para
    %mostrarlo en la caja de texto correspondiente
    handles.src.PacketSize = 1500; %Este parámetro debe estar por debajo del tamaño de los jumbo frames (mtu) de la tarjeta de red
    handles.AT = (handles.infosrc.ExposureTime);
    handles.src.AutoCalibrationMode = 1;
    %handles.src.AcquisitionMode = 'SingleFrame'; Este campo no aparece en
    %R2015a
    handles.src.ExposureMode = 'Timed';
    triggerconfig(handles.vid, 'hardware');
    handles.vid.FramesPerTrigger = Inf;
    handles.vid.TimerPeriod = 1;
    handles.vid.TimerFcn = {@memory_control_callback,handles};
    %handles.vid.ErrorFcn = {'imaqcallbackrestart', handles};
    handles.src.ExposureActiveTriggerMode = 'On';
    set(handles.apertureTime,'String',num2str(handles.AT,'%.2f'));
    
    %Probando el PacketDelay - No disminuye la carga de la CPU - Inútil
    %handles.framesPerSecond = CalculateFrameRate(handles.vid, 100);
    %handles.delay = CalculatePacketDelay(handles.vid, handles.framesPerSecond)
    %src.PacketDelay = handles.delay;
    
    %Obtener las estructuras con todos sus campos
    %(información sobre el estado y la configuración de la cámara)
    handles.infosrc = get(handles.src);
    handles.infoget = get(handles.vid);
    
    %PROBANDO LA AUTOCALIBRACION PERIODICA
    %handles.src.AutoCalibrationInterval = 10;
    
    %Get the axes limits
    vidRes = handles.vid.VideoResolution;
    handles.xlim = [0 vidRes(1)];
    handles.ylim = [0 vidRes(2)];
    
    %Iniciar el objeto de video (empieza a "logear" imágenes, la propiedad
    %"isrunning" pasa a on)
    start(handles.vid);
    h = msgbox('Camera succesfully connected.','Camera Connected');
    enableAll(handles);
    if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
        set(handles.axisSwitch, 'Enable', 'off');
    end
    if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
        set(handles.measAOIPot, 'Enable', 'off');
        set(handles.measPotButton,'Enable', 'off');
    end
    
    %Creamos el colormap personalizado con blanco en el valor máximo
    handles.customJet = [0         0    0.5625
                         0         0    0.6250
                         0         0    0.6875
                         0         0    0.7500
                         0         0    0.8125
                         0         0    0.8750
                         0         0    0.9375
                         0         0    1.0000
                         0    0.0625    1.0000
                         0    0.1250    1.0000
                         0    0.1875    1.0000
                         0    0.2500    1.0000
                         0    0.3125    1.0000
                         0    0.3750    1.0000
                         0    0.4375    1.0000
                         0    0.5000    1.0000
                         0    0.5625    1.0000
                         0    0.6250    1.0000
                         0    0.6875    1.0000
                         0    0.7500    1.0000
                         0    0.8125    1.0000
                         0    0.8750    1.0000
                         0    0.9375    1.0000
                         0    1.0000    1.0000
                    0.0625    1.0000    0.9375
                    0.1250    1.0000    0.8750
                    0.1875    1.0000    0.8125
                    0.2500    1.0000    0.7500
                    0.3125    1.0000    0.6875
                    0.3750    1.0000    0.6250
                    0.4375    1.0000    0.5625
                    0.5000    1.0000    0.5000
                    0.5625    1.0000    0.4375
                    0.6250    1.0000    0.3750
                    0.6875    1.0000    0.3125
                    0.7500    1.0000    0.2500
                    0.8125    1.0000    0.1875
                    0.8750    1.0000    0.1250
                    0.9375    1.0000    0.0625
                    1.0000    1.0000         0
                    1.0000    0.9375         0
                    1.0000    0.8750         0
                    1.0000    0.8125         0
                    1.0000    0.7500         0
                    1.0000    0.6875         0
                    1.0000    0.6250         0
                    1.0000    0.5625         0
                    1.0000    0.5000         0
                    1.0000    0.4375         0
                    1.0000    0.3750         0
                    1.0000    0.3125         0
                    1.0000    0.2500         0
                    1.0000    0.1875         0
                    1.0000    0.1250         0
                    1.0000    0.0625         0
                    1.0000         0         0
                    0.9375         0         0
                    0.8750         0         0
                    0.8125         0         0
                    0.7500         0         0
                    0.6875         0         0
                    0.6250         0         0
                    0.5625         0         0
                    0.5000         0         0];
                
    handles.customJet(64,:) = [1 1 1];
    colormap(handles.customJet);
    
    getImage_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);

    handles.iniXLim = handles.cameraAxes.XLim;
    handles.iniYLim = handles.cameraAxes.YLim;
    handles.iniXTickLabel = handles.cameraAxes.XTickLabel;
    handles.iniYTickLabel = handles.cameraAxes.YTickLabel;
    handles.iniXTick = handles.cameraAxes.XTick;
    handles.iniYTick = handles.cameraAxes.YTick;
    
end

%handles.vid
%handles.src

 %Poner el texto "State" a "Ok" y actualizar la estructura handles
 set(handles.cameraControlState,'String', 'Ok');
 %set(AjusteSatTA, 'UserData', handles);
 guidata(hObject, handles);
 
% --- Executes on button press in startPreview.
function startPreview_Callback(hObject, eventdata, handles)
% hObject    handle to startPreview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto de "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...'); drawnow;

%Deshabilitar todos los controles menos los de tomar una imagen,
%reconectar y volver a empezar preview (por si se detiene)
disableAll(handles);
set(handles.startPreview,'Enable', 'on');
set(handles.getImage,'Enable', 'on');
set(handles.connectCamera,'Enable', 'on');

%La preview solo se puede hacer con los ejes en pixeles, luego se ha de
%desactivar el boton de eje en micras
set(handles.axisSwitch, 'Value', 0);
axisSwitch_Callback(hObject, eventdata, handles);

%Obtener la resolución y si es B/N o RGB, y empezar la preview en la
%figura con el colormap jet
vidRes = handles.vid.VideoResolution;
nBands = handles.vid.NumberOfBands;
image( zeros(vidRes(2), vidRes(1), nBands), 'Parent', handles.cameraAxes );
handles.colorbar = colorbar('Ticks',[0,25,50,75,100,125,150,175,200,225,250],...
         'TickLabels',[0,400,800,1200,1600,2000,2400,2800,3200,3600,4000]);
handles.colorbar.Label.String = 'Pixel values';
handles.colorbar.Label.FontSize = 10;
%Pausa necesaria para que se haga bien la preview cuando los ejes están en
%micras (los ejes deben adaptarse antes de cambiar a pixeles).
pause(0.0001);
set(handles.cameraAxes,'nextplot','replacechildren');

preview(handles.vid, get(handles.cameraAxes, 'Children'));
%colormap(jet)
colormap(handles.customJet)
axis xy
axis on

%Poner el texto de "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in getImage.
function getImage_Callback(hObject, eventdata, handles)
% hObject    handle to getImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%class(handles.cameraAxes)

%Poner el texto de "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...'); drawnow;

%infosrcgui1 = handles.infosrc;
%infogetgui1 = handles.infoget;
%putvar(infosrcgui1);
%putvar(infogetgui1);

handles.infosrc = get(handles.src);
handles.infoget = get(handles.vid);

%Si se encuentra el campo "vid" en la estructura de datos (cámara
%conectada) se detiene la preview, se toma una imágen y se dibuja en
%cameraAxes. Si no, mensaje de error.
if(isfield(handles,'vid'))
    stoppreview(handles.vid);
    handles.image = getsnapshot(handles.vid);
    
    handles.xlim = [0 size(handles.image,2)];
    handles.ylim = [0 size(handles.image,1)];
    
    %Testeo medida potencia
    %image_prueba = handles.image;
    %putvar(image_prueba);
    %infosrcgui2 = handles.infosrc;
    %infogetgui2 = handles.infoget;
    %putvar(infosrcgui2);
    %putvar(infogetgui2);
    
    
    if(get(handles.axisSwitch, 'Value'))
        set(0, 'CurrentFigure', AjusteSatTA);
        %contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0);
        contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0, 'Parent', handles.cameraAxes);
        set(handles.cameraAxes,'nextplot','replacechildren');
    else
        %set(0, 'CurrentFigure', handles.AjusteSatTA);
        set(groot, 'CurrentFigure', handles.AjusteSatTA);
        %handles.cameraAxes = imagesc(handles.image);
        imagesc(handles.image, 'Parent', handles.cameraAxes);
        handles.cameraAxes.XLabel.String = 'Pixels';
        set(handles.cameraAxes,'nextplot','replacechildren');
    end
    colormap(handles.customJet);
    axis xy
    axis on
    
    handles.colorbar = colorbar;
    handles.colorbar.Label.String = 'Pixel values';
    handles.colorbar.Label.FontSize = 10;
else
    h = msgbox('Error. Camera is not connected.','No Connection','error');
end

if(~handles.definingAOI)
    %Hacer un plot del AoI si la hay
    PlotAOI(handles);
end

%Si el modo continuo está desactivado, se activan todos los elementos del
%gui (el modo continuo utiliza este callback, todo debe estar deshabilitado
%mientras se esté en este modo)
if(~get(handles.continuousModeButton,'Value'))
    enableAll(handles);
    if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
        set(handles.axisSwitch, 'Enable', 'off');
    end
    if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
        set(handles.measAOIPot, 'Enable', 'off');
        set(handles.measPotButton,'Enable', 'off');
    end
end

handles.imageSource = 'Camera';

%Poner el texto de "State a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Camera control panel end ----------
%

% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    %Habilitar todos los elementos del gui excepto aquellos controles que
    %necesitan de conexión con la cámara
    enableAll(handles);
    set(handles.continuousModeButton,'Enable', 'off');
    set(handles.apertureTime,'Enable', 'off');
    set(handles.startPotCal,'Enable', 'off');
    set(handles.startSpatialCal,'Enable', 'on');
    if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
        set(handles.axisSwitch, 'Enable', 'off');
    end
    if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
        set(handles.measAOIPot, 'Enable', 'off');
        set(handles.measPotButton,'Enable', 'off');
    end
    if(~isfield(handles,'vid'))
        set(handles.getImage,'Enable', 'off');
        set(handles.startPreview,'Enable', 'off');    
    else
        if(strcmp(handles.vid.Running, 'off'))
            set(handles.getImage,'Enable', 'off');
            set(handles.startPreview,'Enable', 'off');
        end
    end

    %Obtener la ruta completa de la imagen seleccionada, leerla y guardarla en
    %una variable, y actualizar cameraAxes mostrándola
    [handles.imageName,handles.imagePath ]= uigetfile();
    handles.imageFullPath = fullfile(handles.imagePath, handles.imageName);
    handles.image = imread(handles.imageFullPath);
    %handles.cameraAxes = imagesc(handles.image);
    set(groot, 'CurrentFigure', handles.AjusteSatTA);
    imagesc(handles.image, 'Parent', handles.cameraAxes);
    %handles.cameraAxes = imshow(handles.image, [min(min(handles.image)) max(max(handles.image))]);
    axis xy
    axis on

    set(handles.cameraAxes,'nextplot','replacechildren');
    
    handles.xlim = [0 size(handles.image,2)];
    handles.ylim = [0 size(handles.image,1)];
    
    handles.imageSource = 'File';
catch exception
    h = msgbox('Error. Error loading image.','Error loading','error');
end
%Actualizar la estructura handles
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

function apertureTime_Callback(hObject, eventdata, handles)
% hObject    handle to apertureTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if(~get(handles.continuousModeButton, 'Value'))
    %Obtener el valor escrito en la caja de texto editable siempre que no
    %esté activo el modo tracking.
    handles.AT = str2double(get(hObject,'String'));
else
    %Si el modo tracking está activo, modificar el texto del cajetín.
    set(handles.apertureTime, 'String', num2str(handles.AT, '%.2f')); drawnow;
end

%Poner el texto "State" a "Busy...", comprobar la granularity necesaria,
%parar el objeto de video, configurar el nuevo tiempo de apertura
%y volver a iniciar el objeto
set(handles.cameraControlState,'String', 'Busy...'); drawnow;
if(handles.AT < 30*((2^16-1)/1000))
    handles.granularity = 0;
elseif(handles.AT < 2*30*((2^16-1)/1000))
    handles.granularity = 1;
elseif(handles.AT < 3*30*((2^16-1)/1000))
    handles.granularity = 2;
elseif(handles.AT < 4*30*((2^16-1)/1000))
    handles.granularity = 3;
elseif(handles.AT < 5*30*((2^16-1)/1000))
    handles.granularity = 4;
elseif(handles.AT < 6*30*((2^16-1)/1000))
    handles.granularity = 5;
elseif(handles.AT < 7*30*((2^16-1)/1000))
    handles.granularity = 6;
elseif(handles.AT < 8*30*((2^16-1)/1000))
    handles.granularity = 7;
elseif(handles.AT < 9*30*((2^16-1)/1000))
    handles.granularity = 8;
elseif(handles.AT < 10*30*((2^16-1)/1000))
    handles.granularity = 9;
elseif(handles.AT < 11*30*((2^16-1)/1000))
    handles.granularity = 10;
elseif(handles.AT < 12*30*((2^16-1)/1000))
    handles.granularity = 11;
elseif(handles.AT < 13*30*((2^16-1)/1000))
    handles.granularity = 12;
elseif(handles.AT < 14*30*((2^16-1)/1000))
    handles.granularity = 13;
elseif(handles.AT < 15*30*((2^16-1)/1000))
    handles.granularity = 14;
else
    handles.granularity = 40;
end
        
stop(handles.vid);
handles.src.ExposureTimeGranularity = handles.granularity;
handles.src.ExposureTime = handles.AT;
triggerconfig(handles.vid,'hardware');
start(handles.vid);

%Poner el texto de "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Update Histogram panel start ----------
%

% --- Executes on button press in updateHistImage.
function updateHistImage_Callback(hObject, eventdata, handles)
% hObject    handle to updateHistImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Si se ha tomado o cargado alguna imagen
if(isfield(handles,'image'))
    
    %Poner el texto "State" a "Busy..."
    set(handles.cameraControlState,'String', 'Busy...'); drawnow;
    
    %Se obtienen el número de píxeles
    handles.pixelImage = numel(handles.image);
    
    %Si ya existe una figura con histograma se actualiza, si no se crea una
    %nueva
    
    if(isfield(handles,'imageHistogram')&&isgraphics(handles.imageHistogram))
        set(0, 'CurrentFigure', handles.imageHistogram);
        %figure(handles.imageHistogram);
    else
        handles.imageHistogram = figure();
        handles.imageHistogram.NumberTitle = 'Off';
        handles.imageHistogram.Name = 'Image Histogram';
    end
    
    %Decidir el número de bits de la imagen y con ello el valor máximo de
    %pixel posible (no eficaz el 100% de los casos, pero sí la mayoría)
    if(max(max(handles.image))<2^8)
        handles.maxval = 2^8;
    elseif(max(max(handles.image))<2^12)
        handles.maxval = 2^12;
    else
        handles.maxval = 2^16;
    end
    
    %Histograma de la imagen normalizada al valor máximo obtenido
    %anteriormente. Eje x normalizado, eje y (ocurrencias) en porcentaje
    [handles.imagePixelCount Levels] = imhist((double(handles.image)./handles.maxval), handles.maxval);
    bar(Levels, 100.*handles.imagePixelCount./handles.pixelImage);
    xlim([0 1.02]); xlabel('Valor de pixel normalizado'); ylabel('Porcentaje de píxeles');
else
    h = msgbox('Error. No image loaded yet.','No Image','error');
end

%Poner el texto "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in updateHistAOI.
function updateHistAOI_Callback(hObject, eventdata, handles)
% hObject    handle to updateHistAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Si se ha creado una area de interes (AOI)
if(isfield(handles,'mask'))
    
    %Poner el texto "State" a "Busy..."
    set(handles.cameraControlState,'String', 'Busy...'); drawnow;
    
    %Se crea una imagen con todo a 0 excepto el AOI y se obtienen el número
    %de pixeles del AOI (numero de elemenos diferentes de 0).
    handles.AOIimage = (double(handles.image)).*(handles.mask);
    handles.pixelAOI = nnz(handles.AOIimage);
    
    %handles.AOIOk indica si el numero de pixeles del AOI está dentro de lo
    %normal, es decir, si ha habido error en la obtencion del AOI
    handles.AOIOk = (handles.pixelAOI > 30)&&(handles.pixelAOI < 80000);
    
    if(handles.AOIOk)

        %Si ya existe una figura con histograma se actualiza, si no se crea una
        %nueva
        if(isfield(handles,'AOIHistogram')&&isgraphics(handles.AOIHistogram))
            set(0, 'CurrentFigure', handles.AOIHistogram);
            %figure(handles.AOIHistogram);
        else
            handles.AOIHistogram = figure();
            handles.AOIHistogram.NumberTitle = 'Off';
            handles.AOIHistogram.Name = 'AoI Histogram';
        end

        %Decidir el número de bits de la imagen y con ello el valor máximo de
        %pixel posible (no eficaz el 100% de los casos, pero sí la mayoría)
        if(max(max(handles.AOIimage))<2^8)
            handles.maxval = 2^8;
        elseif(max(max(handles.AOIimage))<2^12)
            handles.maxval = 2^12;
        else
            handles.maxval = 2^16;
        end

        %Histograma de la imagen normalizada al valor máximo obtenido
        %anteriormente. Eje x normalizado, eje y (ocurrencias) en porcentaje
        [handles.AOIPixelCount Levels] = imhist(double(handles.AOIimage)./handles.maxval, handles.maxval);
        handles.AOIPixelCount(1) = 0;
        bar(Levels, 100.*handles.AOIPixelCount./handles.pixelAOI);
        xlim([0 1.02]); xlabel('Valor de pixel normalizado'); ylabel('Porcentaje de píxeles(del área)');
    end
else
    h = msgbox('Error. No Area of Interest selected.','No AOI','error');
end

%Poner el texto "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Update Histogram panel end ----------
%

%
% ---------- Area of Interest panel start ----------
%

% --- Executes on button press in getAOI.
function getAOI_Callback(hObject, eventdata, handles)
% hObject    handle to getAOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...');
beep off; drawnow; beep on;

%Ejecutar la función que obtiene el área circular de la imagen que se
%corresponde con un cierto porcentaje de potencia
try
    [handles.AOIcontour, handles.mask, handles.dist] = pottoareacircleUI(handles.image, handles.percPotency);
    if(isfield(handles, 'AOIWarning'))
        delete(handles.AOIWarning);
    end
catch exception
    handles.AOIWarning = warndlg('Warning. AOI not found. If spot is correctly seen, try again.','AOI not found','replace');
end

%Habilitar el botón para la medida de la potencia en un AOI si no se está
%en modo tracking y se ha ejecutado la calibracion de potencia
if(~get(handles.continuousModeButton,'Value')&&isfield(handles,'imageIo')&&isfield(handles,'mask')&&isfield(handles,'K'))
    set(handles.measAOIPot,'Enable', 'on');
end

%Si no ha habido error, actualizar los ejes con la imagen y el AOI
if(~exist ('exception'))
    
    %Actualizar cameraAxes con la imagen (evita que se pinten varias AOI sobre
    %la misma imagen)
    if(get(handles.axisSwitch, 'Value'))
        set(0, 'CurrentFigure', AjusteSatTA);
        %contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0);
        contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0, 'Parent', handles.cameraAxes);
    else
        %set(0, 'CurrentFigure', handles.AjusteSatTA);
        set(groot, 'CurrentFigure', handles.AjusteSatTA);
        %handles.cameraAxes = imagesc(handles.image);
        imagesc(handles.image, 'Parent', handles.cameraAxes);
        %handles.cameraAxes = imshow(handles.image, [min(min(handles.image)) max(max(handles.image))]);
        %set(get(handles.cameraAxes,'Parent'),'nextplot','replacechildren');
    end
    set(handles.cameraAxes,'nextplot','replacechildren');
    colormap(handles.customJet);
    axis xy
    axis on
    handles.AOIType = 'auto';
    
    %Intentar hacer un plot en la figura del AOI encontrada manteniendo la
    %imagen
    try
        PlotAOI(handles);
%         hold(handles.cameraAxes, 'on')
%         if(get(handles.axisSwitch, 'Value'))
%             %handles.cameraAxes = plot(handles.AOIcontour(1,:).*(max(handles.axisXum)/320), handles.AOIcontour(2,:).*(max(handles.axisYum)/256), 'k', 'LineWidth', 2);
%             plot(handles.AOIcontour(1,:).*(max(handles.axisXum)/320), handles.AOIcontour(2,:).*(max(handles.axisYum)/256), 'k', 'LineWidth', 2, 'Parent', handles.cameraAxes);
%         else
%             %handles.cameraAxes = plot(handles.AOIcontour(1,:), handles.AOIcontour(2,:), 'k', 'LineWidth', 2);
%             plot(handles.AOIcontour(1,:), handles.AOIcontour(2,:), 'k', 'LineWidth', 2, 'Parent', handles.cameraAxes);
%         end
%         hold(handles.cameraAxes, 'off')
%         %set(get(handles.cameraAxes,'Parent'),'nextplot','replacechildren');
%         set(handles.cameraAxes,'nextplot','replacechildren');
    catch exception
        if(strcmp(exception.identifier,'MATLAB:hg:set_chck:DimensionsOutsideRange'))
            h = msgbox('Error. Too low percentage, no area found.','Low percentage','error');
        else
            exception.message
            h = msgbox('Error. Unknown error.','Unknown Error','error');
        end
    end
end

%Poner el texto "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

function percPot_Callback(hObject, eventdata, handles)
% hObject    handle to percPot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of percPot as text
%        str2double(get(hObject,'String')) returns contents of percPot as a double

%Obtener del cajetín de texto el valor del porcentaje de potencia deseado
%en el AOI. Error si se introduce un valor fuera del rango 0-100
handles.percPotency = str2double(get(hObject,'String'));
if (handles.percPotency<0)||(handles.percPotency>100)
    h = msgbox('Error. Percentage must be between 0-100.','Invalid percentage','error');
else
    %set(AjusteSatTA, 'UserData', handles);
    guidata(hObject, handles);
end

% --- Executes on button press in defineAOI.
function defineAOI_Callback(hObject, eventdata, handles)

%Poner el texto "State" a "Selecting AOI...", actualizar cameraAxes con la
%última imagen captada y llamar a Dibuja_circulos_interactivos_UI
set(handles.cameraControlState,'String', 'Selecting AOI...'); drawnow;

handles.definingAOI = 1;

if(strcmp(handles.imageSource, 'Camera'))
    getImage_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);
else
    imagesc(handles.image, 'Parent', handles.cameraAxes);
    set(handles.cameraAxes,'nextplot','replacechildren');
    handles.xlim = [0 size(handles.image,2)];
    handles.ylim = [0 size(handles.image,1)];
end

set(handles.cameraAxes,'nextplot','replacechildren');

Dibuja_circulos_interactivos_UI(handles);

%Deshabilitar todos los elementos (uicontrol) de la UI hasta que se 
%seleccione un AOI manualmente
disableAll(handles);

%Esperar a que cambie el callback asociado a presionar una tecla, es
%decir, esperar a que se defina una AOI o se pulse "escape" para cancelar
waitfor(gcf, 'keypressfcn');

%Guardar el círculo devuelto por Dibuja_circulos_interactivos_UI y, si no
%se ha pulsado escape, crear la máscara correspondiente al AOI
handles.AOI = get(gcf,'UserData');
set(gcf, 'UserData', '');
if(~isempty(handles.AOI))
    AOI = handles.AOI;
    center = handles.AOI.Centro;
    handles.AOICenterx = round(real(center));
    handles.AOICentery = round(imag(center));
    handles.AOIRadius = round(handles.AOI.Radio);
    if(handles.axisMicrons)
        handles.AOICenterx = round(handles.AOICenterx/(max(handles.axisXum)/320));
        handles.AOICentery = round(handles.AOICentery/(max(handles.axisYum)/256));
        handles.AOIRadius = round(handles.AOIRadius/(max(handles.axisXum)/320));
    end
    ix = size(handles.image, 2);
    iy = size(handles.image, 1);
    [x,y]=meshgrid(-(handles.AOICenterx-1):(ix-handles.AOICenterx),-(handles.AOICentery-1):(iy-handles.AOICentery));
    handles.mask =((x.^2+y.^2)<=handles.AOIRadius^2);
    handles.AOIImage = (double(handles.image)).*(handles.mask);
    handles.AOIType = 'manual';
    handles.AOI = [];
    handles = rmfield(handles, 'AOI');
else
    PlotAOI(handles);
end

%Habilitar de nuevo todos los elementos, poner el texto "State" a "Ok" y
%actualizar la estructura handles.
enableAll(handles);
if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
    set(handles.axisSwitch, 'Enable', 'off');
end
if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
    set(handles.measAOIPot, 'Enable', 'off');
    set(handles.measPotButton,'Enable', 'off');
end
if(strcmp(handles.imageSource, 'File'))
    set(handles.apertureTime,'Enable', 'off');
    set(handles.startPotCal,'Enable', 'off');
    set(handles.continuousModeButton,'Enable', 'off');
end

handles.definingAOI = 0;

set(handles.cameraControlState,'String', 'Ok'); drawnow;
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Area of Interest panel end ----------
%

%
% ---------- Calibration panel start ----------
%

% --- Executes on button press in startPotCal.
function startPotCal_Callback(hObject, eventdata, handles)
% hObject    handle to startPotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto "State" a "Calibrating power..."
set(handles.cameraControlState,'String', 'Calibrating power...'); drawnow;

handles.initialAxis = handles.axisMicrons;

%Empezar la preview en la figura de la ventana principal
startPreview_Callback(hObject, eventdata, handles);

%Obtener la resolución y si es B/N o RGB, y empezar la preview en la
%figura con el colormap jet
%vidRes = handles.vid.VideoResolution;
%nBands = handles.vid.NumberOfBands;
%image( zeros(vidRes(2), vidRes(1), nBands), 'Parent', handles.cameraAxes);
%preview(handles.vid, get(handles.cameraAxes, 'Children'));
%colormap(handles.customJet)

%Deshabilitar todos los elementos del gui y lanzar el gui para la
%calibración de potencia
disableAll(handles);
PotencyCalibrationUI;

%Esperar a que el gui de calibración de potencia sea cerrado
uiwait(PotencyCalibrationUI);

%Obtener los datos generados en el gui de calibración de potencia (dicho
%gui los pone en el campo "UserData" del gui principal. Concatenar la
%estructura creada con dichos datos con la estructura handles para manejar
%una única estructura con todos los datos.
data = get(handles.AjusteSatTA,'UserData');
handles = catstructmod(handles, data);
set(handles.AjusteSatTA, 'UserData', '');
%handles = catstructmod(data, handles);

%Habilitar de nuevo todos los elementos del gui y actualizar la estructura
%handles.
enableAll(handles);
if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
    set(handles.axisSwitch, 'Enable', 'off');
end
if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
    set(handles.measAOIPot, 'Enable', 'off');
    set(handles.measPotButton,'Enable', 'off');
end

set(handles.axisSwitch, 'Value', handles.initialAxis);
axisSwitch_Callback(hObject, eventdata, handles);

%Poner el texto "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok'); drawnow;
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in startSpatialCal.
function startSpatialCal_Callback(hObject, eventdata, handles)
% hObject    handle to startSpatialCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto "State" a "Calibrating axis..."
set(handles.cameraControlState,'String', 'Calibrating axis...'); drawnow;

handles.initialAxis = handles.axisMicrons;
%Empezar la preview en la figura de la ventana principal si la imagen
%actual es de la cámara
if(strcmp(handles.imageSource, 'Camera'))
    startPreview_Callback(hObject, eventdata, handles);
end

%Obtener la resolución y si es B/N o RGB, y empezar la preview en la
%figura con el colormap jet
%vidRes = handles.vid.VideoResolution;
%nBands = handles.vid.NumberOfBands;
%image( zeros(vidRes(2), vidRes(1), nBands), 'Parent', handles.cameraAxes);
%preview(handles.vid, get(handles.cameraAxes,'Children'));
%colormap(handles.customJet)

%Deshabilitar todos los elementos del gui y lanzar el gui para la
%calibración de los ejes
disableAll(handles);
%SpatialCalibrationUI;

%Esperar a que el gui de calibración espacial sea cerrado
uiwait(SpatialCalibrationUI);

%Obtener los datos generados en el gui de calibración espacial (dicho
%gui los pone en el campo "UserData" del gui principal). Concatenar la
%estructura creada con dichos datos con la estructura handles para manejar
%una única estructura con todos los datos.
data = get(handles.AjusteSatTA,'UserData');
handles = catstructmod(handles, data);
set(handles.AjusteSatTA, 'UserData', '');

set(0, 'CurrentFigure', AjusteSatTA);

%Habilitar de nuevo todos los elementos del gui.
enableAll(handles);
if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
    set(handles.axisSwitch, 'Enable', 'off');
else
    %En caso de que se haya realizado correctamente la calibración espacial
    %se debe añadir la opcion de densidad de potencia al menu de unidades.
    unitStrings = cellstr(get(handles.potUnitMenu,'String'));
    unitStrings{4,1} = 'Power Density in AoI (uW/um^2)';
    set(handles.potUnitMenu,'string',unitStrings);
end
%Si no se ha realizado aún la calibración de potencia, deshabilitar lo que
%corresponda.
if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
    set(handles.measAOIPot, 'Enable', 'off');
    set(handles.measPotButton,'Enable', 'off');
end
%Se la imagen es cargada de un archivo, deshabilitar lo que corresponda.
if(strcmp(handles.imageSource, 'File'))
    set(handles.apertureTime,'Enable', 'off');
    set(handles.startPotCal,'Enable', 'off');
    set(handles.continuousModeButton,'Enable', 'off');
    if(~isfield(handles, 'vid'))
        set(handles.getImage,'Enable', 'off');
        set(handles.startPreview,'Enable', 'off');
    end
end

%Volver a los ejes que había al empezar la calibración espacial
set(handles.axisSwitch, 'Value', handles.initialAxis);
axisSwitch_Callback(hObject, eventdata, handles);

%Poner el texto "State" a "Ok" y actualizar la estructura handles.
set(handles.cameraControlState,'String', 'Ok'); drawnow;
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Calibration panel end ----------
%

%
% ---------- Tracking functions start ----------
%

    % ---------- Buttons Callbacks start ----------

% --- Executes on button press in continuousModeButton.
function continuousModeButton_Callback(hObject, eventdata, handles)
% hObject    handle to continuousModeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Obtene el valor del botón (pulsado o no)
Mode = get(hObject,'Value');

%Si se ha activado al pulsar, deshabilitar todos los elementos del gui menos el propio
%botón (para poder desactivarlo), configurar un periodo para el timer y
%asociarle un callback de "Modo Continuo".
%Si se ha desactivado al pulsar, configurar el callback de control de
%memoria y habilitar todos los elementos del gui
if(Mode)
    disableAll(handles);
    set(handles.continuousModeButton,'Enable', 'on');
    handles.vid.TimerPeriod = 1;
    handles.trackingIterations = 0;
    %Callback para el timer dependiente de si el AOI actual es auto o
    %manual
    if(strcmp(handles.AOIType, 'manual'))
        handles.vid.TimerPeriod = 0.5;
        set(handles.vid, 'TimerFcn', {@manualAOITrackingCallback, hObject});
    else
        set(handles.vid, 'TimerFcn', {@autoAOITrackingCallback, hObject});
    end
else
    handles.vid.TimerFcn = {@memory_control_callback,handles};
    enableAll(handles);
    if(~isfield(handles,'axisXum')||~isfield(handles,'axisYum'))
        set(handles.axisSwitch, 'Enable', 'off');
    end
    if(~isfield(handles,'imageIo') || ~isfield(handles,'mask') || ~isfield(handles,'K'))
        set(handles.measAOIPot, 'Enable', 'off');
        set(handles.measPotButton,'Enable', 'off');
    end
end

%Actualizar la estructura handles.
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in satControlButton.
function satControlButton_Callback(hObject, eventdata, handles)
% hObject    handle to satControlButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of satControlButton

%Se guarda el estado del botón tras pulsarlo.
handles.satControlState = get(hObject,'Value');

if(get(hObject,'Value'))
    set(handles.satPixelText, 'Visible', 'on');
    handles.satControlPhase = 0;
    handles.sat = 0;
    handles.fastSat = 0;
else
    set(handles.satPixelText, 'Visible', 'off');
end

%Actualizar la estructura handles.
%%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in measPotButton.
function measPotButton_Callback(hObject, eventdata, handles)
% hObject    handle to measPotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of measPotButton

%Se guarda el estado del botón tras pulsarlo.
handles.measPotState = get(hObject,'Value');
%Actualizar la estructura handles.
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

% --- Executes on button press in noiseControlButton.
function noiseControlButton_Callback(hObject, eventdata, handles)
% hObject    handle to noiseControlButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of noiseControlButton

%Se guarda el estado del botón tras pulsarlo.
handles.backNoiseState = get(hObject,'Value');
%Actualizar la estructura handles.
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

    % ---------- Buttons Callbacks end ----------

    % ---------- Timed Callbacks start ----------

function autoAOITrackingCallback(src, eventdata, hObject)

handles = guidata(hObject);
handles.trackingIterations = handles.trackingIterations+1;
%handles = get(AjusteSatTA, 'UserData');

%getImage_Callback junto con measAOIPot_Callback
%Se toma una imagen y, si se ha ejecutdo la calibración de potencia
%correctamente y se ha definido un AOI, se mide la potencia en dicha AOI

%getImage_Callback(hObject, eventdata, handles);
%handles = guidata(hObject);

if(isfield(handles,'vid'))
    stoppreview(handles.vid);
    handles.image = getsnapshot(handles.vid);
else
    h = msgbox('Error. Camera is not connected.','No Connection','error');
end

%handles = get(AjusteSatTA, 'UserData');
getAOI_Callback(hObject, eventdata, handles);
handles = guidata(hObject);
%handles = get(AjusteSatTA, 'UserData');

%Si está activado el control de saturacion, con cada imagen que se tome
%deberia obtenerse el histograma, calcularse el % de pixeles saturados (en
%los ultimos ragos del histograma), y se comprueba si se supera un umbral
%de saturacion. Mostrar el % de pixeles saturados en alguna parte.
%Si se supera dicho umbral, ejecutar una rutina para solucionar la
%saturacion (o preguntar al usuario si la quiere ejecutar).
if(handles.satControlState)
    satControlCallback(hObject, eventdata);
    
    handles = guidata(hObject);
    %handles = get(AjusteSatTA, 'UserData');

    %Crear la cadena de caracteres para mostrar en la interfaz el
    %porcentaje de pixeles saturados del total del AOI y actualizar dicho
    %texto en el interfaz.
    string = strcat(handles.fixtextsatPixels, {' '}, num2str(handles.percSat, '%.2f'), '%');
    set(handles.satPixelText, 'String', string); drawnow;
end

%Si está activado el control de AOI por encima del fondo de ruido, se llama
%al callback de control correspondiente con cada iteracion del tracking
if(handles.backNoiseState)
    backNoiseControlCallback(hObject, eventdata);
    
    handles = guidata(hObject);
    %handles = get(AjusteSatTA, 'UserData');
end

%Si está activada la medida de potencia, se ejecuta el callback de medida
%de potencia
if(handles.measPotState)
    measAOIPot_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);
end

%Eliminar imágenes logeadas (control de memoria) y actualizar estructura
%handles.
flushdata(handles.vid);
%set(AjusteSatTA, 'UserData', handles);

guidata(hObject, handles);

function satControlCallback(hObject, eventdata)

handles = guidata(hObject);
%handles = get(AjusteSatTA, 'UserData');

%if(isfield(handles,'a'))
%    handles.a = handles.a+1;
%else
%    handles.a = 1;
%end
%handles.a

%Se va calculando y mostrando el histograma tanto de la imagen completa
%como del AOI con cada iteración del tracking.
updateHistImage_Callback(hObject, eventdata, handles);
handles = guidata(hObject);
%handles = get(AjusteSatTA, 'UserData');
updateHistAOI_Callback(hObject, eventdata, handles);
handles = guidata(hObject);
%handles = get(AjusteSatTA, 'UserData');

%Si el cálculo del AOI se realiza correctamente:
if(handles.AOIOk)

    %Se calcula el número de píxeles en los ultimos contenedores del histograma
    %y se calcula el porcentaje con respecto al total de pixeles del AOI
    handles.satPixel = sum(handles.AOIPixelCount(round(handles.maxval*0.98):handles.maxval));
    handles.percSat = (handles.satPixel/handles.pixelAOI)*100;

    %Los umbrales de saturacion podrían ser configurables por el usuario.
    %Hay un primer umbral de saturación para un control rápido (si solo se
    %supera este), otro mayor para control lento (si se superan ambos), y
    %uno menor que los dos anteriores para parar el control de saturación.
    %En este caso el umbral rápido es del 5%, el lento del 10%, y el de
    %parada del 4.5%.
    handles.thresholdSat = 14;
    handles.thresholdSatFast = 5;
    handles.thresholdSatStop = 4.5;

    %Si hay saturación(se supera el umbral rápido): modificar el flag de 
    %saturación para indicar que se está saturado. Si no se supera el
    %umbral mayor (lento), se activa el flag de control rápido.
    %Entrar en la fase correspondiente: inicio del control rápido (sólo una
    %fase en el proceso de autoajuste) o control lento (tres fases con
    %diferentes pasos en el proceso de autoajuste).
    %Se deshabilita el boton del modo tracking hasta que se ajuste el TA
    
    %Indicador handles.satControlPhase
    %handles.satControlPhase = XY
    % X --> Tipo de autoajuste. 1 - Autoajuste rápido ; 2 - Autoajuste lento.
    % Y --> Fase del autoajuste. (Sólo 1 para rápido, 3 para lento).
    if(handles.percSat > handles.thresholdSatFast)
        handles.satWarning = warndlg('Warning! Saturation over threshold!','Saturation!','replace');
        set(handles.satWarning, 'Position', [20 40 190 70]);
        handles.sat = 1;
        if(handles.percSat < handles.thresholdSat)
            handles.fastSat = 1;
        else
            handles.fastSat = 0;
        end
        if(handles.satControlPhase == 0 && handles.fastSat == 0)
            handles.satControlPhase = 11;
        elseif(handles.satControlPhase == 0 && handles.fastSat == 1)
            handles.satControlPhase = 21;
        end
        set(handles.continuousModeButton, 'Enable', 'off');  
    else
        if(isfield(handles, 'satWarning'))
            delete(handles.satWarning);
        end
        handles.sat = 0;
        %handles.a = 0;
    end

    %RUTINA AUTOAJUSTE SATURACION

    %Aplicar pasos de TA fijos: x2, x1.4, x1.1
    step1 = 2; step2 = 1.4; step3 = 1.1;

    %Aplicar paso de TA correspondiente dependiendo de la fase del control
    %de saturacion que se esté llevando a cabo.
    switch handles.satControlPhase
        
        %FASE Rápida - Paso fino. Se disminuye el TA en un factor x1.1hasta
        %salir de saturación, tras lo cual finaliza el autoajuste. Pensado
        %para cuando se tiene saturación, pero con un % bajo cercano al
        %umbral de saturación.
        case 21
            if((~handles.sat)&&(handles.percSat < handles.thresholdSatStop))
                handles.satControlPhase = 0;
                %Se rehabilita el boton del modo tracking puesto que ya se
                %ha ajustado la saturacion
                set(handles.continuousModeButton, 'Enable', 'on');
            else
                handles.AT = handles.AT/step3;
                apertureTime_Callback(hObject, eventdata, handles);
                handles = guidata(hObject);
                %handles = get(AjusteSatTA, 'UserData');
            end
        %FASE 1 - Paso grueso. Se disminuye el TA en un factor x2 hasta
        %salir de saturacion, tras lo cual se pasa a la fase 2. Primera
        %fase del autoajuste lento. Pensado para cuando se tiene mucha
        %saturación, con un % alejado del umbral de saturación.
        case 11
            if(handles.sat)
                handles.AT = handles.AT/step1;
                apertureTime_Callback(hObject, eventdata, handles);
                handles = guidata(hObject);
                %handles = get(AjusteSatTA, 'UserData');
            else
                handles.satControlPhase = 12;
            end
        %FASE 2 - Paso medio. Se aumenta el TA en un factor x1.2 hasta
        %entrar de nuevo en saturacion, tras lo cual se pasa a la fase 3.        
        case 12
            if(~handles.sat)
                handles.AT = handles.AT*step2;
                apertureTime_Callback(hObject, eventdata, handles);
                handles = guidata(hObject);
                %handles = get(AjusteSatTA, 'UserData');
            else
                handles.satControlPhase = 13;
            end
        %FASE 3 - Paso fino. Se disminuye el TA en un factor x1.05 hasta
        %salir de saturacion, tras lo cual finaliza el control (fase 0).
        case 13
            if((~handles.sat)&&(handles.percSat < handles.thresholdSatStop))
                handles.satControlPhase = 0;
                %Se rehabilita el boton del modo tracking puesto que ya se
                %ha ajustado la saturacion
                set(handles.continuousModeButton, 'Enable', 'on');
            else
                handles.AT = handles.AT/step3;
                apertureTime_Callback(hObject, eventdata, handles);
                handles = guidata(hObject);
                %handles = get(AjusteSatTA, 'UserData');
            end
        otherwise
    end
    
end

%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

function backNoiseControlCallback(hObject, eventdata)

handles = guidata(hObject);
%handles = get(AjusteSatTA, 'UserData');

%Si no se ha hecho en el control de saturación, se va calculando y
%mostrando el histograma tanto de la imagen completa como del AOI con cada
%iteración del tracking.
if(~handles.satControlState)
    updateHistImage_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);
    %handles = get(AjusteSatTA, 'UserData');
    updateHistAOI_Callback(hObject, eventdata, handles);
    handles = guidata(hObject);
    %handles = get(AjusteSatTA, 'UserData');
end

%Si el cálculo del AOI ha sido correcto:
if(handles.AOIOk)
    
    %Se calcula el ruido de fondo y se establece el umbral como tres veces
    %dicho valor
    handles.noiseImage = handles.image - uint16(handles.AOIimage);
    handles.meanNoise = mean(mean(handles.noiseImage));
    handles.noiseThreshold = round(3*handles.meanNoise);
    
    %Se calcula el número de píxeles por debajo del umbral (tres veces el
    %ruido de fondo) y se calcula el porcentaje con respecto al total de
    %pixeles del AOI
    handles.noisePixel = sum(handles.AOIPixelCount(1:handles.noiseThreshold));
    handles.percNoise = (handles.noisePixel/handles.pixelAOI)*100;
    
    %El umbral de pixeles por debajo del ruido podria ser configurable por
    %el usuario. En este caso es el 50% de los pixeles del AOI
    handles.pixelThresholdNoise = 50;
    
    %Si se tiene muchos pixeles por debajo del ruido de fondo:
    %poner el flag "underNoise" a 1 y aumentar el TA
    %Si no se tienen muchos pixeles por debajo del ruido de fondo se
    %elimina el warning (si lo hay) y se pone el flag "underNoise" a 0
    if(handles.percNoise > handles.pixelThresholdNoise)
        handles.noiseWarning = warndlg('Warning! Most of the pixels are near or under the background noise!','AOI under noise!','replace');
        handles.underNoise = 1;
        %Aumentar el TA para evitar que se este por debajo del ruido. En
        %este caso se aumenta en un factor 3.
        handles.AT = handles.AT*3;
        apertureTime_Callback(hObject, eventdata, handles);
        handles = guidata(hObject);
        %handles = get(AjusteSatTA, 'UserData');
    else
        if(isfield(handles, 'noiseWarning'))
            delete(handles.noiseWarning);
        end
        handles.underNoise = 0;
    end
    
end

%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

function manualAOITrackingCallback(src, eventdata, hObject)

%Esta función debe ejecutarse sólo si se entra en modo tracking cuando el
%AOI definida es un AOI manual
%En la creación de dicha AOI manual se debieron obtener los parámetros
%correspondientes a su contorno o máscara y su posición. La región de
%búsqueda se ha de definir aquí.

%Cargar la estructura handles del GUI
handles = guidata(hObject);

%Poner el texto "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...'); drawnow;

handles.trackingIterations = handles.trackingIterations+1;

%Si es la primera vez que se ejecuta el callback del tracking manual,
%guardar la imagen del AOI y las coordenadas del centro del spot
%encontrados en dicha imagen como los "iniciales" para la corrección de las
%derivas.

if(handles.trackingIterations == 1)
    handles.iniAOIImage = handles.AOIImage;
    handles.iniAOICenterx = handles.AOICenterx;
    handles.iniAOICentery = handles.AOICentery;
end

if(isfield(handles,'vid'))
    stoppreview(handles.vid);
    handles.image = getsnapshot(handles.vid);
else
    h = msgbox('Error. Camera is not connected.','No Connection','error');
end

handles.corrThreshold = 0.8;

handles.lastSearch = 0;
handles.searchRegionDim = 3;
pixelStep = 4;

first = 1;
handles.AOIFound = 0;

while((~handles.AOIFound)&&(~handles.lastSearch)||(first))
    
    handles.AOISearchStep = handles.AOIRadius*handles.searchRegionDim;

    %Definicion inicial de la región de búsqueda
    handles.AOISearchRegion = [handles.AOICenterx-handles.AOISearchStep...
       handles.AOICentery-handles.AOISearchStep handles.AOICenterx+handles.AOISearchStep...
       handles.AOICentery+handles.AOISearchStep]; %[x1 y1 x2 y2]

    %Valor maximo de cada eje X e Y almacenado y usado en lugar del size de la
    %imagen. Debería solucionar el problema con el eje en micras.
    %if(handles.axisMicrons)
    %   maxX = max(handles.axisXum);
    %   maxY = max(handles.axisYum);
    %else
       maxX = size(handles.image,2);
       maxY = size(handles.image,1);
    %end

    %Si la región de búsqueda se sale de la imagen por alguno de sus bordes se
    %ajuste al borde correspondiente.
    if(((handles.AOICenterx-handles.AOISearchStep)<0))
       handles.AOISearchRegion(1) = 0;
       handles.AOISearchRegion(3) = 2*handles.AOISearchStep;
    end
    if(((handles.AOICentery-handles.AOISearchStep)<0))
       handles.AOISearchRegion(2) = 0;
       handles.AOISearchRegion(4) = 2*handles.AOISearchStep;
    end
    if(((handles.AOICenterx+handles.AOISearchStep)>maxX))
       handles.AOISearchRegion(3) = maxX;
       handles.AOISearchRegion(1) = maxX-2*handles.AOISearchStep;
    end
    if(((handles.AOICentery+handles.AOISearchStep)>maxY))
       handles.AOISearchRegion(4) = maxY;
       handles.AOISearchRegion(2) = maxY-2*handles.AOISearchStep;
    end
    if(((handles.AOICenterx-handles.AOISearchStep)<0)&&((handles.AOICenterx+handles.AOISearchStep)>maxX))
        handles.AOISearchRegion(1) = 0;
        handles.AOISearchRegion(3) = maxX;
    end
    if(((handles.AOICentery-handles.AOISearchStep)<0)&&((handles.AOICentery+handles.AOISearchStep)>maxY))
        handles.AOISearchRegion(2) = 0;
        handles.AOISearchRegion(4) = maxY;
    end

    %Si los bordes de la región de búsqueda coinciden con los de la imagen (es
    %decir, la región de búsqueda es la imagen completa) se activa un flag
    %indicando que se trata de la última iteración de la búsqueda.
    if((handles.AOISearchRegion(1) == 0)&&(handles.AOISearchRegion(3) == maxX)...
       &&(handles.AOISearchRegion(2) == 0)&&(handles.AOISearchRegion(4) == maxY))
       handles.lastSearch = 1;
    end

    %Region de busqueda definida handles.AOISearchRegion
    %handles.AOISearchRegion
    %set(handles.cameraAxes,'nextplot','replacechildren');
    %hold(handles.cameraAxes, 'on')
    %plot([handles.AOISearchRegion(1), handles.AOISearchRegion(1), handles.AOISearchRegion(3), handles.AOISearchRegion(3)],[handles.AOISearchRegion(2), handles.AOISearchRegion(4), handles.AOISearchRegion(2), handles.AOISearchRegion(4)], 'x', 'Parent', handles.cameraAxes);
    %set(handles.cameraAxes,'nextplot','replacechildren');
    %hold(handles.cameraAxes, 'off')

    %Realizar barrido obteniendo corr2
    %Con dichos parámetros, se debe ir recorriendo la región de búsqueda
    %moviendo el AOI inicial y obteniendo su correlación con el AOI de la
    %imagen anterior.

    handles.corr = zeros(round(2*handles.AOISearchStep/pixelStep));
    ix = maxX;
    iy = maxY; 
    
    %%¿Seria esta la forma correcta?
    iterationx = 0;
    %numiters =(((handles.AOISearchRegion(3)-handles.AOIRadius)-(handles.AOISearchRegion(1)+handles.AOIRadius))/pixelStep)*(((handles.AOISearchRegion(4)-handles.AOIRadius)-(handles.AOISearchRegion(2)+handles.AOIRadius))/pixelStep);
    %numiters
    
    %Primer bucle con paso de pixel grande para encontrar, dentro de la
    %región de búsqueda grande, una primera estimación de la localización
    %del AOI. Posteriormente se ejecuta un segundo bucle con paso de un
    %pixel, pero en una región muy pequeña alrededor de la estimada
    %anteriormente.
    
    for(centerx = (handles.AOISearchRegion(1)+handles.AOIRadius):pixelStep:(handles.AOISearchRegion(3)-handles.AOIRadius))
        iterationx = iterationx+1;
        iterationy = 0;
        for(centery = (handles.AOISearchRegion(2)+handles.AOIRadius):pixelStep:(handles.AOISearchRegion(4)-handles.AOIRadius))
            iterationy = iterationy+1;

    %       Crear la imagen o máscara igual que el AOI manual con centro
    %       en la posición (x,y). Obtener la corr2 entre esta y el AOI manual
    %       de la imagen anterior y guardar el resultado en la posicion (x,y)
    %       de handles.corr

           [x,y]=meshgrid(-(centerx-1):(ix-centerx),-(centery-1):(iy-centery));
           handles.maskCorr =((x.^2+y.^2)<=handles.AOIRadius^2);
           handles.AOIImageCorr = (double(handles.image)).*(handles.maskCorr);

    %       Copiar en una nueva matriz solo los valores distintos de 0 de
    %       ambas imagenes de AOI para el corr2, si no no va a funcionar
    
           handles.AOIImageCorr = handles.AOIImageCorr(centery-handles.AOIRadius+1:centery+handles.AOIRadius,centerx-handles.AOIRadius+1:centerx+handles.AOIRadius);
            
           %Si se han ejecutado X iteraciones del callback del tracking o
           %un multiplo, utilizar la imagen con AOI "inicial" para corregir
           %así las derivas.
           if(mod(handles.trackingIterations,30)==0)
               handles.AOIImageCut = handles.iniAOIImage(handles.iniAOICentery-handles.AOIRadius+1:handles.iniAOICentery+handles.AOIRadius,handles.iniAOICenterx-handles.AOIRadius+1:handles.iniAOICenterx+handles.AOIRadius);
           else
               handles.AOIImageCut = handles.AOIImage(handles.AOICentery-handles.AOIRadius+1:handles.AOICentery+handles.AOIRadius,handles.AOICenterx-handles.AOIRadius+1:handles.AOICenterx+handles.AOIRadius);
           end
           
           %handles.AOIImageCorr2(iterationy, iterationx) = handles.AOIImageCorr(centery-handles.AOIRadius+1:centery+handles.AOIRadius,centerx-handles.AOIRadius+1:centerx+handles.AOIRadius);
           %handles.AOIImageCut(iterationy, iterationx) = handles.AOIImage(handles.AOICentery-handles.AOIRadius+1:handles.AOICentery+handles.AOIRadius,handles.AOICenterx-handles.AOIRadius+1:handles.AOICenterx+handles.AOIRadius);

           handles.corr(iterationy, iterationx) = corr2(handles.AOIImageCut, handles.AOIImageCorr);       
       end
    end
    
    %iterationx*iterationy
    
    %Al finalizar la primera búsqueda se ha de obtener el punto que ha
    %obtenido mayor correlación para estimar la zona donde realizar la
    %búsqueda fina. La zona de búsqueda fina será un cuadrado de lado 2
    %veces el paso de pixel utilizado y con centro el punto de máxima
    %correlación encontrado.
    
    [c, idx ] = max(handles.corr(:));
    [maxCorrYEst, maxCorrXEst] = ind2sub( size(handles.corr), idx );
    maxCorrYEst = maxCorrYEst*pixelStep+(handles.AOISearchRegion(2)+handles.AOIRadius)-pixelStep;
    maxCorrXEst = maxCorrXEst*pixelStep+(handles.AOISearchRegion(1)+handles.AOIRadius)-pixelStep;
    
    handles.AOIEstimateRegion = [maxCorrXEst-pixelStep...
       maxCorrYEst-pixelStep maxCorrXEst+pixelStep...
       maxCorrYEst+pixelStep];
   
   handles.corr2 = zeros(size(handles.AOIEstimateRegion,1), size(handles.AOIEstimateRegion,1));
   
   %La segunda búsqueda tendrá un paso de un sólo pixel y recorrerá el
   %cuadrado de pequeñas dimensiones definido anteriormente.
   iterationx = 0;
   for(centerx = handles.AOIEstimateRegion(1):handles.AOIEstimateRegion(3))
        iterationx = iterationx+1;
        iterationy = 0;
        for(centery = handles.AOIEstimateRegion(2):handles.AOIEstimateRegion(4))
            iterationy = iterationy+1;

    %       Crear la imagen o máscara igual que el AOI manual con centro
    %       en la posición (x,y). Obtener la corr2 entre esta y el AOI manual
    %       de la imagen anterior y guardar el resultado en la posicion (x,y)
    %       de handles.corr

           [x,y]=meshgrid(-(centerx-1):(ix-centerx),-(centery-1):(iy-centery));
           handles.maskCorr =((x.^2+y.^2)<=handles.AOIRadius^2);
           handles.AOIImageCorr = (double(handles.image)).*(handles.maskCorr);

    %       Copiar en una nueva matriz solo los valores distintos de 0 de
    %       ambas imagenes de AOI para el corr2, si no no va a funcionar
           
           try
               
               handles.AOIImageCorr = handles.AOIImageCorr(centery-handles.AOIRadius+1:centery+handles.AOIRadius,centerx-handles.AOIRadius+1:centerx+handles.AOIRadius);
               
               %Si se han ejecutado X iteraciones del callback del tracking o
               %un multiplo, utilizar la imagen con AOI "inicial" para corregir
               %así las derivas.
               if(mod(handles.trackingIterations,30)==0)
                   handles.AOIImageCut = handles.iniAOIImage(handles.iniAOICentery-handles.AOIRadius+1:handles.iniAOICentery+handles.AOIRadius,handles.iniAOICenterx-handles.AOIRadius+1:handles.iniAOICenterx+handles.AOIRadius);
               else
                   handles.AOIImageCut = handles.AOIImage(handles.AOICentery-handles.AOIRadius+1:handles.AOICentery+handles.AOIRadius,handles.AOICenterx-handles.AOIRadius+1:handles.AOICenterx+handles.AOIRadius);
               end
               
               %handles.AOIImageCorr2(iterationy, iterationx) = handles.AOIImageCorr(centery-handles.AOIRadius+1:centery+handles.AOIRadius,centerx-handles.AOIRadius+1:centerx+handles.AOIRadius);
               %handles.AOIImageCut(iterationy, iterationx) = handles.AOIImage(handles.AOICentery-handles.AOIRadius+1:handles.AOICentery+handles.AOIRadius,handles.AOICenterx-handles.AOIRadius+1:handles.AOICenterx+handles.AOIRadius);

               handles.corr2(iterationy, iterationx) = corr2(handles.AOIImageCut, handles.AOIImageCorr);
           catch exception
           end
       end
    end

    %Al finalizar el recorrido, la nueva AOI se colocará en la
    %posición con mayor correlación con respecto a la de la anterior imagen
    %(sólo se modifica la posición, no la forma de la AOI). Si ninguna de las
    %posiciones utilizadas supera un cierto umbral de correlación, se debe
    %agrandar la región de búsqueda y volver a recorrer la región (parcial o
    %totalmente).
    
    [c, idx ] = max(handles.corr2(:));
    [deltay, deltax] = ind2sub( size(handles.corr2), idx );
    maxCorrY = maxCorrYEst-pixelStep-1+deltay;
    maxCorrX = maxCorrXEst-pixelStep-1+deltax;
    %maxCorrY = maxCorrY*pixelStep+(handles.AOISearchRegion(2)+handles.AOIRadius)-pixelStep;
    %maxCorrX = maxCorrX*pixelStep+(handles.AOISearchRegion(1)+handles.AOIRadius)-pixelStep;

    %Si el maximo de todas las correlaciones obtenidas supera cierto umbral se
    %considera que se ha encontrado el objeto. Se actualiza el valor de las
    %coordenadas del centro del AOI, se genera la nueva máscara y la nueva
    %imagen con sólo el AOI y se vuelve a pintar el contorno del AOI en la
    %imagen.
    if(max(max(handles.corr))>handles.corrThreshold)
       handles.AOICenterx = maxCorrX;
       handles.AOICentery = maxCorrY;
       [x,y]=meshgrid(-(handles.AOICenterx-1):(ix-handles.AOICenterx),-(handles.AOICentery-1):(iy-handles.AOICentery));
       handles.mask =((x.^2+y.^2)<=handles.AOIRadius^2);
       handles.AOIImage = (double(handles.image)).*(handles.mask);

       handles.AOIFound = 1;
       
       %Si está activado el control de saturacion, con cada imagen que se tome
       %deberia obtenerse el histograma, calcularse el % de pixeles saturados (en
       %los ultimos ragos del histograma), y se comprueba si se supera un umbral
       %de saturacion. Mostrar el % de pixeles saturados en alguna parte.
       %Si se supera dicho umbral, ejecutar una rutina para solucionar la
       %saturacion (o preguntar al usuario si la quiere ejecutar).
       if(handles.satControlState)
           satControlCallback(hObject, eventdata);

           handles = guidata(hObject);

           %Crear la cadena de caracteres para mostrar en la interfaz el
           %porcentaje de pixeles saturados del total del AOI y actualizar dicho
           %texto en el interfaz.
           string = strcat(handles.fixtextsatPixels, {' '}, num2str(handles.percSat, '%.2f'), '%');
           set(handles.satPixelText, 'String', string); drawnow;
       end

       %Si está activado el control de AOI por encima del fondo de ruido, se llama
       %al callback de control correspondiente con cada iteracion del tracking
       if(handles.backNoiseState)
           backNoiseControlCallback(hObject, eventdata);
           handles = guidata(hObject);
        end

       %Si está activada la medida de potencia, se ejecuta el callback de medida
       %de potencia
       if(handles.measPotState)
           measAOIPot_Callback(hObject, eventdata, handles);
           handles = guidata(hObject);
       end
       
    else

        handles.AOIFound = 0;

        if(handles.lastSearch)
            %Anunciar que no se ha encontrado el AoI tras recorrer la imagen
            %completa
            handles.AOIWarning = warndlg('Warning. AOI not found. If spot is correctly seen, try again.','AOI not found','replace');
        else
            %Aumentar al doble las dimensiones de la región de búsqueda y
            %modificar el paso en el bucle de calculo de la correlación.
            handles.searchRegionDim = handles.searchRegionDim*2;
            pixelStep = pixelStep*2;
        end
    end
    
    first = 0;
    
end

%El paso para la búsqueda debe ser lo suficientemente pequeño como para
%tener precisión en la búsqueda, pero lo suficientemente grande como para
%que el recorrido de la región de búsqueda se haga de forma rápida.

%Actualizar los ejes con la imagen y el AOI

%Actualizar cameraAxes con la imagen (evita que se pinten varias AOI sobre
%la misma imagen)
if(get(handles.axisSwitch, 'Value'))
    set(0, 'CurrentFigure', AjusteSatTA);
    contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0, 'Parent', handles.cameraAxes);
else
    set(groot, 'CurrentFigure', handles.AjusteSatTA);
    imagesc(handles.image, 'Parent', handles.cameraAxes);
end
set(handles.cameraAxes,'nextplot','replacechildren');
colormap(handles.customJet);
axis xy
axis on

%Intentar hacer un plot en la figura del AOI encontrada manteniendo la
%imagen
PlotAOI(handles);

flushdata(handles.vid);

%Poner el texto "State" a "Ok" y actualizar la estructura handles
set(handles.cameraControlState,'String', 'Ok');

guidata(hObject, handles);


    % ---------- Timed Callbacks end ----------

%
% ---------- Tracking functions end ----------
%

%
% ---------- Fugire Control panel start ----------
%

% --- Executes on button press in interactiveZoom.
function interactiveZoom_Callback(hObject, eventdata, handles)
% hObject    handle to interactiveZoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of interactiveZoom

%Si no existe el campo del zoom en la estructura handles, se crea.
if(~isfield(handles, 'z'))
    handles.z = zoom;
    handles.z.ActionPostCallback = {@zoomTickLabelsFix,handles};
end

if(get(hObject,'Value'))
    %Poner el texto "State" a "Zooming..."
    set(handles.cameraControlState,'String', 'Zooming...'); drawnow;
    
    %Guardar todos los enable de los controles del gui, deshabilitarlos
    %todos(menos el del propio zoom) y activar el zoom interactivo
    saveEnable(handles);
    disableAll(handles);
    handles.z.Enable = 'on';
    set(handles.interactiveZoom,'Enable', 'on');
else
    %Poner el texto "State" a "Ok"
    set(handles.cameraControlState,'String', 'Ok'); drawnow;
    
    %Desactivar el zoom interactivo, y habilitar los controles que
    %estuvieran activados cuando se activó el zoom
    handles.z.Enable = 'off';
    loadEnable(handles);
end

% --- Executes on button press in axisSwitch.
function axisSwitch_Callback(hObject, eventdata, handles)
% hObject    handle to axisSwitch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of axisSwitch

%Poner el texto "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...'); drawnow;

handles.axisMicrons = get(handles.axisSwitch,'Value');

%Según el estado del botón, se deben tener los ejes X e Y en pixeles o en
%micras.
try
    %Si el botón está pulsado se hace un contourf con los ejes en micras y
    %se cambia el texto del botón para indicar que al volver a pulsar se
    %cambiará a eje en píxeles
    if(handles.axisMicrons)
        set(handles.cameraAxes,'nextplot','replace');
        handles.contour = contourf(handles.axisXum, handles.axisYum, handles.image, 70, 'LineWidth', 0, 'Parent', handles.cameraAxes);
        colormap(handles.customJet);
        axis xy
        axis on
        handles.cameraAxes.XLabel.String = 'Microns';
        set(handles.axisSwitch, 'String', 'Switch axis to pixels');
        
%         handles.iniumXLim = [0 max(handles.axisXum)];
%         handles.iniumYLim = [0 max(handles.axisYum)];
%         handles.iniumXTickLabel = handles.cameraAxes.XTickLabel;
%         handles.iniumYTickLabel = handles.cameraAxes.YTickLabel;
%         handles.iniumXTick = handles.cameraAxes.XTick;
%         handles.iniumYTick = handles.cameraAxes.YTick;
        
        set(handles.cameraAxes,'nextplot','replacechildren');
    else
        %Si el botón no está pulsado se hace un imagesc y se cambia el
        %texto del botón para indicar que al volver a pulsar se cambiará a
        %eje en micras
        imagesc(handles.image, 'Parent', handles.cameraAxes);
        colormap(handles.customJet);
        axis xy
        axis on
        %Arreglar el zoom al hacer un cambio en los ejes
        if(strcmp(handles.imageSource, 'Camera'))
            handles = axisZoomSwitchFix(handles);
        end
        handles.cameraAxes.XLabel.String = 'Pixels';
        set(handles.axisSwitch, 'String', 'Switch axis to microns');
        set(handles.cameraAxes,'nextplot','replacechildren');
    end
    handles.colorbar = colorbar;
    handles.colorbar.Label.String = 'Pixel values';
    handles.colorbar.Label.FontSize = 10;
    PlotAOI(handles);
catch exception
    if handles.axisMicrons == get(hObject,'Max')
        set(hObject,'Value', 0);
        handles.axisMicrons = 0;
    else
        set(hObject,'Value', 1);
        handles.axisMicrons = 1;
    end
    exception.message
    h = msgbox('Error. Impossible to switch axis to microns or pixels.','Axis to microns error','error');
end

%Poner el texto "State" a "Ok" y actualizar la estructura handles.
set(handles.cameraControlState,'String', 'Ok'); drawnow;
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Fugire Control panel end ----------
%

%
% ---------- Measurement functions start ----------
%

% --- Executes on button press in measAOIPot.
function measAOIPot_Callback(hObject, eventdata, handles)
% hObject    handle to measAOIPot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Poner el texto "State" a "Busy..."
set(handles.cameraControlState,'String', 'Busy...'); drawnow;

%Consultar las unidades escogidas (ejecutar potUnitMenu_Callback)
potUnitMenu_Callback(handles.potUnitMenu, eventdata, handles);
handles = guidata(handles.potUnitMenu);

try
%Crear las imágenes(tanto con spot como sin él para corriente de oscuridad)
%sólo con el AOI para integrar la potencia en ellas
handles.AOIimageSpot = (double(handles.image)).*(handles.mask);
handles.AOIimageIo = (double(handles.imageIo)).*(handles.mask);

%handles.AOIimageNoIo = handles.AOIimageSpot - handles.AOIimageIo;
%figure(40); imagesc(handles.AOIimageNoIo);

%Obtener la potencia en el AOI para la imagen del spot(I) y de
%oscuridad(Io - Tomada en la calibracion)
handles.spotPot = integrateImage(handles.AOIimageSpot);
handles.IoPot = integrateImage(handles.AOIimageIo);


%Calcular la potencia en el AOI (en microWattios) siguiendo la fórmula:
% Potencia(uW) = root_slope((I-Io)/K)/TA
%handles.potFiberuW = 1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*(1e6*handles.src.ExposureTime));
handles.potFiberuW = 1e3*(1/(1e-6*handles.src.ExposureTime))*nthroot(((handles.spotPot-handles.IoPot)/handles.K), handles.slope);

%¿Y esto? ¿Sumar para luego restar tal cual? En cualquier caso no se usa en ninguna parte...
%handles.potFiberdBu = (10*log10(handles.potFiberuW)-(10*log10(handles.potCalFibermW*1e3)))+(10*log10(handles.potCalFibermW*1e3));
handles.potFiberdBu = 10*log10(handles.potFiberuW);

%Corrección de la medida de potencia (Innecesario con nueva formula?)
%handles.potFiberdBuCorrected = ((10*log10(handles.potFiberuW)-(10*log10(handles.potCalFibermW*1e3)))/0.853)+(10*log10(handles.potCalFibermW*1e3));
%handles.potFiberuWCorrected = 10^((handles.potFiberdBuCorrected)/10);
%handles.potFiberdBmCorrected = handles.potFiberdBuCorrected-30;
%disp('Sin corrección')
%10*log10(handles.potFiberuW)-30
%disp('Con corrección')
%handles.potFiberdBmCorrected

%Switch para calcular y representar la potencia en las unidades
%correspondientes
switch handles.potUnit
    case 'Power in AoI (uW)'
        %Calcular la potencia en el AOI (en microWattios) siguiendo la fórmula:
        % Potencia(uW) = 1000*K*(I-Io)/(G*TA(s))
        %handles.potFiberuW = 1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*(1e6*handles.src.ExposureTime));
        
        %%%TESTEANDO CORRECCION DE LA MEDIDA DE POTENCIA%%%
        %handles.potFiberdBuCorrected = ((10*log10(handles.potFiberuW)-(10*log10(handles.potCalFibermW*1e3)))/0.853)+(10*log10(handles.potCalFibermW*1e3));
        %handles.potFiberdBmCorrected = handles.potFiberdBuCorrected-30;
        %disp('Sin corrección')
        %10*log10(handles.potFiberuW)-30
        %disp('Con corrección')
        %handles.potFiberdBmCorrected
        %%%---------------------------------------------%%%
        
        %%%TESTEANDO MEDIDA DE POTENCIA%%%
%         handles.n=1;
%         handles.potencianW = 0; handles.potenciadbm50 = 0;
%         potencianW = 0; potenciadbm50 = 0;
%         handles.potencianW(handles.n) = handles.potFiberuW*1e3;
%         handles.potenciadbmcorr50(handles.n) = handles.potFiberdBuCorrected-30;
%         handles.potenciadbm50(handles.n) = handles.potFiberdBu-30;
%         handles.TA_potensia(handles.n) = handles.src.ExposureTime;
%         handles.spotPotTest(handles.n) = handles.spotPot;
%         TA_potensia = handles.TA_potensia;
%         potenciadbmcorr50 = handles.potenciadbmcorr50;
%         potenciadbm50 = handles.potenciadbm50;
%         potencianW = handles.potencianW;
%         spotPotTest = handles.spotPotTest;
%         putvar(TA_potensia);
%         putvar(potenciadbmcorr50);
%         putvar(potenciadbm50);
%         putvar(potencianW);
%         putvar(spotPotTest);
%         handles.n = handles.n+1;
        %%%----------------------------%%%

        %Crear la cadena de caracteres para mostrar en la interfaz la potencia
        %medida y actualizar dicho texto en el interfaz.
        string = strcat(handles.fixtextMeasAOIPot, {' '}, num2str(handles.potFiberuW, '%.5g'), ' uW');
        set(handles.potAOIText, 'String', string);
   case 'Energy in AoI (J)'
        %Calcular la energía en el AOI (en microJulios) siguiendo la fórmula:
        %Energia(J) = 1000*K*(I-Io)/(G*1e6)
        %handles.potFiberJ = 1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*1e6);
        handles.potFiberJ = handles.potFiberuW*handles.src.ExposureTime;

        %Crear la cadena de caracteres para mostrar en la interfaz la
        %energia medida y actualizar dicho texto en el interfaz.
        string = strcat(handles.fixtextMeasAOIPot, {' '}, num2str(handles.potFiberJ, '%.5g'), ' J');
        set(handles.potAOIText, 'String', string);
   case 'Photons in AoI'
        %Calcular los fotones en el AOI siguiendo la fórmula:
        %Fotones = 1000*K*(I-Io)/(G*E(de 1un photon))
        %handles.potFiberPhotons = 1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*(h*c/lambda));
        %handles.potFiberPhotons = 1e6*1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*(((6.626e-34)*(3e8))/(1550e-9)));
        handles.potFiberPhotons = handles.potFiberuW*1e6*handles.src.ExposureTime/(((6.626e-34)*(3e8))/(1550e-9));

        %Crear la cadena de caracteres para mostrar en la interfaz la potencia
        %medida y actualizar dicho texto en el interfaz.
        string = strcat(handles.fixtextMeasAOIPot, {' '}, num2str(handles.potFiberPhotons, '%.4g'), ' Photons');
        set(handles.potAOIText, 'String', string);
   case 'Power Density in AoI (uW/um^2)'
        %Calcular la densidad de potencia en el AOI (en microWattios por
        %micrómetro cuadrado) siguiendo la fórmula:
        %Densidad de potencia(uW/um^2) = 1000*K*(I-Io)/(G*Area(um^2))
        handles.AOIradiuspix = mean([max(handles.AOIcontour(1,:))-min(handles.AOIcontour(1,:)) max(handles.AOIcontour(2,:))-min(handles.AOIcontour(2,:))]);
        if(~handles.magX==0)
            handles.AOIradiusum = handles.AOIradiuspix*30/handles.magX;
        elseif(~handles.magY==0)
            handles.AOIradiusum = handles.AOIradiuspix*30/handles.magY;
        end
        %handles.potFiberuWum2 = 1e3*handles.K*(handles.spotPot-handles.IoPot)/(handles.src.Gain*(1e6*handles.src.ExposureTime)*(pi*handles.AOIradiusum^2));
        handles.potFiberuWum2 = handles.potFiberuW/(pi*handles.AOIradiusum^2);
        
        %Crear la cadena de caracteres para mostrar en la interfaz la potencia
        %medida y actualizar dicho texto en el interfaz.
        string = strcat(handles.fixtextMeasAOIPot, {' '}, num2str(handles.potFiberuWum2, '%.3e'), ' uW/um^2');
        set(handles.potAOIText, 'String', string);
end

catch exception
    %if(strcmp(exception.identifier,'MATLAB:hg:set_chck:DimensionsOutsideRange'))
        h = msgbox('Error. Area of Interest is not defined or calibration missing.','No AOI or calibration','error');
        exception.message
    %elseif(strcmp(exception.identifier,'MATLAB:hg:set_chck:DimensionsOutsideRange'))
    %    h = msgbox('Error. Potency calibration is needed for the measurement.','No Potency Calibration','error');
    %end
end

%Poner el texto "State" a "Ok" y actualizar la estructura handles.
set(handles.cameraControlState,'String', 'Ok'); drawnow;
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);
%guidata(AjusteSatTA, handles);

% --- Executes on selection change in potUnitMenu.
function potUnitMenu_Callback(hObject, eventdata, handles)
% hObject    handle to potUnitMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns potUnitMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from potUnitMenu

%Se obtiene el contenido del menú y posteriormente el string seleccionado.
contents = cellstr(get(hObject,'String'));
handles.potUnit = contents{get(hObject,'Value')};
%handles.potUnit
%strcmp(handles.potUnit, 'Photons in AOI')
%set(AjusteSatTA, 'UserData', handles);
guidata(hObject, handles);

%
% ---------- Measurement functions end ----------
%

% --- Executes when user attempts to close AjusteSatTA.
function AjusteSatTA_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to AjusteSatTA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Si se ha creado el objeto de video, parar la preview, detener el objeto de
%video y eliminarlo. Ejecutar finalmente un imaqreset por si acaso.
if(isfield(handles,'vid'))
    stoppreview(handles.vid);
    stop(handles.vid);
    flushdata(handles.vid);
    delete(handles.vid);
    imaqreset;
end

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Función que representa el último AoI definida en la imagen
function PlotAOI(handles)

if(isfield(handles,'AOICenterx')||isfield(handles,'AOIcontour'))
    hold(handles.cameraAxes, 'on')
    if(strcmp(handles.AOIType, 'manual'))
        %Plot si el AoI es de tipo manual
        if(handles.axisMicrons)
            viscircles([handles.AOICenterx.*(max(handles.axisXum)/320), handles.AOICentery.*(max(handles.axisYum)/256)], handles.AOIRadius.*(max(handles.axisXum)/320), 'EdgeColor', 'k','LineWidth', 2);
        else
            viscircles([handles.AOICenterx, handles.AOICentery], handles.AOIRadius, 'EdgeColor', 'k','LineWidth', 2);
        end
    else
        %Plot si el AoI es de tipo automático
        if(handles.axisMicrons)
            plot(handles.AOIcontour(1,:).*(max(handles.axisXum)/320), handles.AOIcontour(2,:).*(max(handles.axisYum)/256), 'k', 'LineWidth', 2, 'Parent', handles.cameraAxes);
        else
            plot(handles.AOIcontour(1,:), handles.AOIcontour(2,:), 'k', 'LineWidth', 2, 'Parent', handles.cameraAxes);
        end
    end
    hold(handles.cameraAxes, 'off')
    set(handles.cameraAxes,'nextplot','replacechildren');
    axis xy
    axis on
end

function zoomTickLabelsFix(obj, eventdata, handles)

%Si los limites de la imagen mostrada en los ejes son los iniciales (sin
%zoom) entonces se han de utilizar los labels originales en los ejes.
%NO FUNCIONARA CORRECTAMENTE CON EJES EN MICRAS
handles.cameraAxes.XTickLabelMode = 'auto';
handles.cameraAxes.YTickLabelMode = 'auto';
handles.cameraAxes.XTickMode = 'auto';
handles.cameraAxes.YTickMode = 'auto';
if(handles.cameraAxes.XLim == handles.iniXLim)
    handles.cameraAxes.XTickLabel = handles.iniXTickLabel;
    handles.cameraAxes.XTick = handles.iniXTick;
end
if(handles.cameraAxes.YLim == handles.iniYLim)
    handles.cameraAxes.YTickLabel = handles.iniYTickLabel;
    handles.cameraAxes.YTick = handles.iniYTick;
end

function handles = axisZoomSwitchFix(handles)

if(isfield(handles, 'magX'))
    if((handles.cameraAxes.XLim(1) ~= handles.iniXLim(1))&&(handles.cameraAxes.XLim(2) ~= handles.iniXLim(2))&&...
            ((handles.cameraAxes.XLim(1)/(handles.Tpix/handles.magX))>(handles.iniXLim(1)))&&...
            ((handles.cameraAxes.XLim(2)/(handles.Tpix/handles.magX))<(handles.iniXLim(2))))
        handles.cameraAxes.XLim = handles.cameraAxes.XLim./(handles.Tpix/handles.magX);
    end
    if((handles.cameraAxes.YLim(1) ~= handles.iniYLim(1))&&(handles.cameraAxes.YLim(2) ~= handles.iniYLim(2))&&...
            ((handles.cameraAxes.YLim(1)/(handles.Tpix/handles.magY))>(handles.iniYLim(1)))&&...
            ((handles.cameraAxes.YLim(2)/(handles.Tpix/handles.magY))<(handles.iniYLim(2))))
        handles.cameraAxes.YLim = handles.cameraAxes.YLim./(handles.Tpix/handles.magY);
    end
end


% --- Función encargada de integrar la "potencia"(valor de pixel acumulado)
%en una imagen
function P = integrateImage(image)

% Integra la "potencia" en una imagen, es decir, obtiene el sumatorio de
% todos los pixeles en ella.
P = sum(sum(image));

function disableAll(handles)
% Deshabilita todos los uicontrol de la interfaz (botones, cajetines de
% texto, etc...)

set(handles.apertureTime,'Enable', 'off');
set(handles.startPreview,'Enable', 'off');
set(handles.getImage,'Enable', 'off');
set(handles.connectCamera,'Enable', 'off');
set(handles.loadImage,'Enable', 'off');
set(handles.getAOI,'Enable', 'off');
set(handles.percPot,'Enable', 'off');
set(handles.defineAOI,'Enable', 'off');
set(handles.updateHistAOI,'Enable', 'off');
set(handles.updateHistImage,'Enable', 'off');
set(handles.continuousModeButton,'Enable', 'off');
set(handles.startPotCal,'Enable', 'off');
set(handles.startSpatialCal,'Enable', 'off');
set(handles.measAOIPot,'Enable', 'off');
set(handles.interactiveZoom,'Enable', 'off');
set(handles.axisSwitch,'Enable', 'off');
set(handles.satControlButton,'Enable', 'off');
set(handles.measPotButton,'Enable', 'off');
set(handles.noiseControlButton,'Enable', 'off');

function enableAll(handles)
% Habilita todos los uicontrol de la interfaz (botones, cajetines de
% texto, etc...)

set(handles.apertureTime,'Enable', 'on');
set(handles.startPreview,'Enable', 'on');
set(handles.getImage,'Enable', 'on');
set(handles.connectCamera,'Enable', 'on');
set(handles.loadImage,'Enable', 'on');
set(handles.getAOI,'Enable', 'on');
set(handles.percPot,'Enable', 'on');
set(handles.defineAOI,'Enable', 'on');
set(handles.updateHistAOI,'Enable', 'on');
set(handles.updateHistImage,'Enable', 'on');
set(handles.continuousModeButton,'Enable', 'on');
set(handles.startPotCal,'Enable', 'on');
set(handles.startSpatialCal,'Enable', 'on');
set(handles.measAOIPot,'Enable', 'on');
set(handles.interactiveZoom,'Enable', 'on');
set(handles.axisSwitch,'Enable', 'on');
set(handles.satControlButton,'Enable', 'on');
set(handles.measPotButton,'Enable', 'on');
set(handles.noiseControlButton,'Enable', 'on');

function saveEnable(handles)
% Habilita todos los uicontrol de la interfaz (botones, cajetines de
% texto, etc...)

handles.apertureTimeEnable = get(handles.apertureTime,'Enable');
handles.startPreviewEnable = get(handles.startPreview,'Enable');
handles.getImageEnable = get(handles.getImage,'Enable');
handles.connectCameraEnable = get(handles.connectCamera,'Enable');
handles.loadImageEnable = get(handles.loadImage,'Enable');
handles.getAOIEnable = get(handles.getAOI,'Enable');
handles.percPotEnable = get(handles.percPot,'Enable');
handles.defineAOIEnable = get(handles.defineAOI,'Enable');
handles.updateHistAOIEnable = get(handles.updateHistAOI,'Enable');
handles.updateHistImageEnable = get(handles.updateHistImage,'Enable');
handles.continuousModeButtonEnable = get(handles.continuousModeButton,'Enable');
handles.startPotCalEnable = get(handles.startPotCal,'Enable');
handles.startSpatialCalEnable = get(handles.startSpatialCal,'Enable');
handles.measAOIPotEnable = get(handles.measAOIPot,'Enable');
handles.interactiveZoomEnable = get(handles.interactiveZoom,'Enable');
handles.axisSwitchEnable = get(handles.axisSwitch,'Enable');
handles.satControlButtonEnable = get(handles.satControlButton, 'Enable');
handles.measPotButtonEnable = get(handles.measPotButton, 'Enable');
handles.noiseControlButtonEnable = get(handles.noiseControlButton, 'Enable');

%set(AjusteSatTA, 'UserData', handles);
guidata(AjusteSatTA, handles);

function loadEnable(handles)
% Habilita todos los uicontrol de la interfaz (botones, cajetines de
% texto, etc...)

set(handles.apertureTime,'Enable', handles.apertureTimeEnable);
set(handles.startPreview,'Enable', handles.startPreviewEnable);
set(handles.getImage,'Enable', handles.getImageEnable);
set(handles.connectCamera,'Enable', handles.connectCameraEnable);
set(handles.loadImage,'Enable', handles.loadImageEnable);
set(handles.getAOI,'Enable', handles.getAOIEnable);
set(handles.percPot,'Enable', handles.percPotEnable);
set(handles.defineAOI,'Enable', handles.defineAOIEnable);
set(handles.updateHistAOI,'Enable', handles.updateHistAOIEnable);
set(handles.updateHistImage,'Enable', handles.updateHistImageEnable);
set(handles.continuousModeButton,'Enable', handles.continuousModeButtonEnable);
set(handles.startPotCal,'Enable', handles.startPotCalEnable);
set(handles.startSpatialCal,'Enable', handles.startSpatialCalEnable);
set(handles.measAOIPot,'Enable', handles.measAOIPotEnable);
set(handles.interactiveZoom,'Enable', handles.interactiveZoomEnable);
set(handles.axisSwitch,'Enable', handles.axisSwitchEnable);
set(handles.satControlButton,'Enable', handles.satControlButtonEnable);
set(handles.measPotButton,'Enable', handles.measPotButtonEnable);
set(handles.noiseControlButton,'Enable', handles.noiseControlButtonEnable);
