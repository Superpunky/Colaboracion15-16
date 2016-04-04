function varargout = SpatialCalibrationUI(varargin)
% SPATIALCALIBRATIONUI MATLAB code for SpatialCalibrationUI.fig
%      SPATIALCALIBRATIONUI, by itself, creates a new SPATIALCALIBRATIONUI or raises the existing
%      singleton*.
%
%      H = SPATIALCALIBRATIONUI returns the handle to a new SPATIALCALIBRATIONUI or the handle to
%      the existing singleton*.
%
%      SPATIALCALIBRATIONUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPATIALCALIBRATIONUI.M with the given input arguments.
%
%      SPATIALCALIBRATIONUI('Property','Value',...) creates a new SPATIALCALIBRATIONUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SpatialCalibrationUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SpatialCalibrationUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SpatialCalibrationUI

% Last Modified by GUIDE v2.5 01-Apr-2016 13:05:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SpatialCalibrationUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SpatialCalibrationUI_OutputFcn, ...
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


% --- Executes just before SpatialCalibrationUI is made visible.
function SpatialCalibrationUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SpatialCalibrationUI (see VARARGIN)

%Se busca el manejador de la gui principal, y, si existe, se obtiene la
%estructura handles de ésta. Se combinan las estructuras handles de ambas
%gui para trabajar con una única estructura de datos.
handles.mainFig = findobj('Tag','AjusteSatTA');
if ~isempty(handles.mainFig)
    data = guidata(handles.mainFig);
    handles = catstructmod(data, handles);
end

handles.fixDistanceText = 'Distance between points in pixels:';

% Choose default command line output for SpatialCalibrationUI
handles.output = hObject;

%Actualizar la estructura handles
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SpatialCalibrationUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function distanceXText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distanceXText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in getImageSpatialCalibration.
function getImageSpatialCalibration_Callback(hObject, eventdata, handles)
% hObject    handle to getImageSpatialCalibration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Se deshabilita el propio botón, se toma una imagen
set(handles.getImageSpatialCalibration,'Enable', 'off');
handles.imageSpatialCalibration = getsnapshot(handles.vid);

%Se habilita el siguiente botón (siguiente paso de la calibración)
set(handles.getPoints,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in getPoints.
function getPoints_Callback(hObject, eventdata, handles)
% hObject    handle to getPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Deshabilitar el propio botón.
set(handles.getPoints,'Enable', 'off');

%Abrir en una nueva ventana la imagen tomada
%handles.imageSpatialCalibration y permitir seleccionar dos pixeles de la
%imagen. Guardar sus coordenadas y calcular la diferencia en pixeles entre
%ellos. Actualizar el cuadro de texto correspondiente. Mirar getpts
%Hacerlo creando un objeto imdistline, obteniendo su api, y ejecutando las
%correspondientes funciones de la api cuando el usuario fije los puntos
%(pulsando intro o algo así, parecido a lo que hizo iñigo).
handles.SpatialCalFig = figure();
imagesc(handles.imageSpatialCalibration); colormap(jet);
h = imdistline(gca);
handles.api = iptgetapi(h); %No se puede acceder a api desde fuera de la funcion. Utilizar handles o guidata o algo.

set(handles.SpatialCalFig,'keypressfcn',{@medir_distancia_callback, handles});
uiwait(handles.SpatialCalFig);

data = get(handles.SpatialCalibrationUI,'UserData');
handles = catstructmod(handles, data);

%Si se presiona la tecla correcta se bloquea el objeto imdistline, se
%obtiene la distancia o la posición, y palante.

%
%
%¿Cuándo se cierra la ventana con el imdistline?

%handles.x1 = x1; handles.y1 = y1; handles.x2 = x2; handles.y2 = y2;
if(ishandle(handles.SpatialCalFig))
%¿Habilitar los botones cuando se pulsa o cuando se seleccionan los puntos?
    set(handles.distanceGet,'Enable', 'on');
    set(handles.distanceXText,'Enable', 'on');
    set(handles.distanceYText,'Enable', 'on');
else
    restartSpatialCal_Callback(hObject, eventdata, handles)
end

%Actualizar la estructura handles.
guidata(hObject, handles);

function medir_distancia_callback(hObject, eventdata, handles)

%Se obtiene la tecla pulsada que ha activado el callback
tecla=get(hObject,'currentkey');

%Si la tecla pulsada es "intro", se obtiene la distancia y la posicion de
%imdistline con su api. Las posiciones de inicio y fin de la linea se
%guardan y se hace un plot de ambos puntos sobre la imagen que tenía la
%herramienta imdistline. Finalmente se elimina el callback asociado a la
%pulsación de una tecla para que no se vuelva a ejecutar, se elimina la api
%y el objeto imdistline, y se envía un resume para que continue la
%ejecución normal.
if(strcmp(tecla,'return'))
    dist = handles.api.getDistance();
    pos = handles.api.getPosition(); %pos = [X1 Y1; X2 Y2]
    handles.X1 = pos(1,1); handles.Y1 = pos(1,2); handles.X2 = pos(2,1); handles.Y2 = pos(2,2);
    hold on;
    plot(handles.X1, handles.Y1, 'xk');
    plot(handles.X2, handles.Y2, 'xk');
    hold off;
    set(handles.SpatialCalFig,'keypressfcn','');
    handles.api.delete();
    uiresume(handles.SpatialCalFig);
end

set(handles.SpatialCalibrationUI,'UserData', handles);

%Actualizar la estructura handles.
%guidata(hObject, handles);


% --- Executes on button press in distanceGet.
function distanceGet_Callback(hObject, eventdata, handles)
% hObject    handle to distanceGet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Obtener los valores introducidos en los cajetines de texto distanceXText
handles.distanceXum = str2double(get(handles.distanceXText,'String'));
handles.distanceYum = str2double(get(handles.distanceYText,'String'));

%Si no se introdujo nada o si no es un número real se pone el cajetín
%vacío, se borra el campo de la estructura handles y se genera un mensaje
%de error.
if(isnan(handles.distanceXum)||(~isreal(handles.distanceXum)))
    set(handles.distanceXText,'String', '');
    rmfield(handles, 'distanceXum');
    h = msgbox('Error. Not a valid distance value. Must be a real number.','Invalid pot. value','error');
    
elseif(isnan(handles.distanceYum)||(~isreal(handles.distanceYum)))
    set(handles.distanceYText,'String', '');
    rmfield(handles, 'distanceYum');
    h = msgbox('Error. Not a valid distance value. Must be a real number.','Invalid pot. value','error');
%Si los valores son valores adecuados se deshabilitan el botón y los
%cajetines de texto, y se habilita el siguiente botón.
else
    set(handles.distanceXText,'Enable', 'off');
    set(handles.distanceYText,'Enable', 'off');
    set(handles.distanceGet,'Enable', 'off');
    set(handles.calibrateSpatial,'Enable', 'on');
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in calibrateSpatial.
function calibrateSpatial_Callback(hObject, eventdata, handles)
% hObject    handle to calibrateSpatial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hacer el calculo correspondiente y sacar M y los nuevos ejes x e y y tal

try
    T = 30;
    handles.distanceXpix = abs(handles.X1-handles.X2);
    handles.distanceYpix = abs(handles.Y1-handles.Y2);
    handles.magX = 0; handles.magY = 0;
    if(handles.distanceXum ~= 0)
        handles.magX = (handles.distanceXpix*T)/handles.distanceXum;
    end
    if(handles.distanceYum ~= 0)
    handles.magY = (handles.distanceYpix*T)/handles.distanceYum;
    end
    
    %Ejes en píxeles
    handles.axisXpix = 1:handles.xlim(2);
    handles.axisYpix = 1:handles.ylim(2);
    %Ejes en micras = ejes en pixeles*tamaño en pixeles(T)*magnificacion
    if((handles.distanceXum ~= 0)||(handles.distanceYum ~= 0))
        if((handles.distanceXum ~= 0)&&(handles.distanceYum ~= 0))
            handles.axisXum = linspace(0, (handles.xlim(2)-1)*T/handles.magX, handles.xlim(2));
            handles.axisYum = linspace(0, (handles.ylim(2)-1)*T/handles.magY, handles.ylim(2));
        elseif(handles.distanceYum == 0)
            handles.axisXum = linspace(0, (handles.xlim(2)-1)*T/handles.magX, handles.xlim(2));
            handles.axisYum = linspace(0, (handles.ylim(2)-1)*T/handles.magX, handles.ylim(2));
        elseif(handles.distanceXum == 0)
            handles.axisXum = linspace(0, (handles.xlim(2)-1)*T/handles.magY, handles.xlim(2));
            handles.axisYum = linspace(0, (handles.ylim(2)-1)*T/handles.magY, handles.ylim(2));
        end
    else
        %Se lanza una excepción para hacer un restart y mostrar el mensaje
        %de error por pantalla.
        throw(exception);
    end
    %Se crea un vector de resultados con todos los datos interesantes de la
    %calibración ()
    handles.resultsSpatialCal = {handles.X1, handles.X2, handles.distanceXpix, 30, handles.magX, handles.magY;
        handles.Y1, handles.Y2, handles.distanceYpix, '', '', ''}';
    %Se carga el vector de resultados en la tabla spatialCalResults, se
    %deshabilita el botón y se habilita el de reset de la calibración.
    set(handles.spatialCalResults,'data', []);
    set(handles.spatialCalResults,'data', handles.resultsSpatialCal);
    set(handles.calibrateSpatial,'Enable', 'off');
    set(handles.restartSpatialCal,'Enable', 'on');
    set(handles.saveSpatialCal,'Enable', 'on');
    
%Si hay un error, generar mensaje y resetear la calibración
catch exception
    %Lanzar mensaje de error
    h = msgbox('Error. Spatial calibration error. Invalid distances.','Spatial Calibration Error','error');
    exception.message
    %Reiniciar la calibración espacial
    restartSpatialCal_Callback(hObject, eventdata, handles);
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in restartSpatialCal.
function restartSpatialCal_Callback(hObject, eventdata, handles)
% hObject    handle to restartSpatialCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%¿Eliminar todos los campos de handles creados? Creo que sería necesario.
%rmfield(handles, 'distanceXText');

%Resetear todos los botones y textos al estado inicial.
%set(handles.pixelDistanceText,'String',handles.fixDistanceText);
set(handles.distanceXText,'String', '');
set(handles.distanceYText,'String', '');
set(handles.getImageSpatialCalibration,'Enable', 'on');
set(handles.getPoints,'Enable', 'off');
set(handles.distanceXText,'Enable', 'off');
set(handles.distanceYText,'Enable', 'off');
set(handles.distanceGet,'Enable', 'off');
set(handles.calibrateSpatial,'Enable', 'off');
set(handles.restartSpatialCal,'Enable', 'off');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes when user attempts to close SpatialCalibrationUI.
function SpatialCalibrationUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to SpatialCalibrationUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
set(handles.AjusteSatTA,'UserData', handles);
%Parar la Preview en ventana principal
stoppreview(handles.vid);

delete(hObject);



% --- Executes on button press in saveSpatialCal.
function saveSpatialCal_Callback(hObject, eventdata, handles)
% hObject    handle to saveSpatialCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SpatialCalibrationUI_CloseRequestFcn(SpatialCalibrationUI, eventdata, handles)


function distanceXText_Callback(hObject, eventdata, handles)
% hObject    handle to distanceXText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function distanceYText_Callback(hObject, eventdata, handles)
% hObject    handle to distanceYText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distanceYText as text
%        str2double(get(hObject,'String')) returns contents of distanceYText as a double


% --- Executes during object creation, after setting all properties.
function distanceYText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distanceYText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
