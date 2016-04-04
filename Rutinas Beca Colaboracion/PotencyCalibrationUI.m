function varargout = PotencyCalibrationUI(varargin)
% POTENCYCALIBRATIONUI MATLAB code for PotencyCalibrationUI.fig
%      POTENCYCALIBRATIONUI, by itself, creates a new POTENCYCALIBRATIONUI or raises the existing
%      singleton*.
%
%      H = POTENCYCALIBRATIONUI returns the handle to a new POTENCYCALIBRATIONUI or the handle to
%      the existing singleton*.
%
%      POTENCYCALIBRATIONUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POTENCYCALIBRATIONUI.M with the given input arguments.
%
%      POTENCYCALIBRATIONUI('Property','Value',...) creates a new POTENCYCALIBRATIONUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PotencyCalibrationUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PotencyCalibrationUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PotencyCalibrationUI

% Last Modified by GUIDE v2.5 01-Apr-2016 13:05:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PotencyCalibrationUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PotencyCalibrationUI_OutputFcn, ...
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


% --- Executes just before PotencyCalibrationUI is made visible.
function PotencyCalibrationUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PotencyCalibrationUI (see VARARGIN)

%Se busca el manejador de la gui principal, y, si existe, se obtiene la
%estructura handles de ésta. Se combinan las estructuras handles de ambas
%gui para trabajar con una única estructura de datos.
handles.mainFig = findobj('Tag','AjusteSatTA');
if ~isempty(handles.mainFig)
    data = guidata(handles.mainFig);
    handles = catstructmod(data, handles);
end
% Choose default command line output for PotencyCalibrationUI
handles.output = hObject;

%Se crea la cadena de texto fijo para el diámetro del spot.
handles.fixspotDiameterText = 'Spot diameter:';

%Actualizar la estructura handles
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = PotencyCalibrationUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function potFiberText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to potFiberText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in getImageIo.
function getImageIo_Callback(hObject, eventdata, handles)
% hObject    handle to getImageIo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Se deshabilita el propio botón, se toma una imagen, y se calcula el nivel
%medio de los píxeles en la imagen.
set(handles.getImageIo,'Enable', 'off');
handles.imageIo = getsnapshot(handles.vid);
handles.Io = sum(sum(handles.imageIo))/numel(handles.imageIo);
%integrateImage(handles.imageIo);

%Se obtiene el texto fijo y se concatena con el resultado obtenido.
handles.fixtext = get(handles.IoText,'String');
set(handles.IoText,'String', strcat(handles.fixtext, ' ', num2str(handles.Io,5)));

%Se habilita el siguiente botón (siguiente paso de la calibración)
set(handles.getSpotImage,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in getSpotImage.
function getSpotImage_Callback(hObject, eventdata, handles)
% hObject    handle to getSpotImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Deshabilitar el propio botón, capturar la imagen con el spot, habilitar el
%siguiente botón y su cajetín de texto (siguiente paso de la calibración).
set(handles.getSpotImage,'Enable', 'off');
handles.imageSpot = getsnapshot(handles.vid);
set(handles.potFiberGet,'Enable', 'on');
set(handles.potFiberText,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in potFiberGet.
function potFiberGet_Callback(hObject, eventdata, handles)
% hObject    handle to potFiberGet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Obtener el valor introducido en el cajetín de texto potFiberText
handles.potFiberdBm = str2double(get(handles.potFiberText,'String'));

%Si no se introdujo nada o si no es un número real se pone el cajetín
%vacío, se borra el campo de la estructura handles y se genera un mensaje
%de error.
if(isnan(handles.potFiberdBm)||(~isreal(handles.potFiberdBm)))
    set(handles.potFiberText,'String', '');
    rmfield(handles, 'potFiberText');
    h = msgbox('Error. Not a valid potency value. Must be a real number.','Invalid pot. value','error');
    
%Si el valor es un valor adecuado se deshabilitan el botón y el cajetín de
%texto, se habilita el siguiente botón, y se adecúa el valor indicado al
%real en el plano de la punta de la fibra.
else
    set(handles.potFiberText,'Enable', 'off');
    set(handles.potFiberGet,'Enable', 'off');
    set(handles.calibratePot,'Enable', 'on');
    %Se resta la reflexión de Fresnel (Pot. trans. 96% de la incidente)
    handles.potFiberdBm = handles.potFiberdBm - 0.177;
    %Comprobar calculo con medidor de potencia del laser
    handles.potFibermW = (10^(handles.potFiberdBm/10));
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in calibratePot.
function calibratePot_Callback(hObject, eventdata, handles)
% hObject    handle to calibratePot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%I - Suma del valor de todos los píxeles en la imagen del spot en el area
%con el 99% de potencia
%Io - Suma del valor de oscuridad de todos los píxeles en la imagen de
%oscuridad en el area con el 99% de potencia (area de la imagen del spot
%obviamente)

try
    
    %Se obtiene el área de la imagen del spot que contiene el 99% de potencia
    [handles.AOIcontourCal, handles.maskCal, handles.distCal] = pottoareacircleUI(handles.imageSpot, 99);
    
    %Se obtienen los diámetros en X e Y del AOI y se genera la cadena de
    %caracteres para mostrar en la interfaz dichos datos
    diamx = max(handles.AOIcontourCal(1,:)) - min(handles.AOIcontourCal(1,:));
    diamy = max(handles.AOIcontourCal(2,:)) - min(handles.AOIcontourCal(2,:));
    string = strcat(handles.fixspotDiameterText, {' '}, num2str(diamx,3), ' pix (X)', {' '}, num2str(diamy,3), ' pix (Y)');
    set(handles.spotDiameterText, 'String', string);
    
    %Crear las imágenes sólo con el AOI para integrar la potencia en ellas
    handles.AOIimageSpot = (double(handles.imageSpot)).*(handles.maskCal);
    handles.AOIimageIo = (double(handles.imageIo)).*(handles.maskCal);

    %Obtener la potencia en el AOI para la imagen del spot(I) y de
    %oscuridad(Io)
    handles.spotPot = integrateImage(handles.AOIimageSpot);
    handles.IoPot = integrateImage(handles.AOIimageIo);
    
    %Calcular la constante de calibración K sabiendo la potencia en el
    %plano de la punta de la fibra, siguiendo la siguiente fórmula:
    % K = P(mW)*G*TA(s)/(I-Io)
    handles.K = (handles.potFibermW)*(handles.src.Gain)*(1e6*(handles.src.ExposureTime))/(handles.spotPot-handles.IoPot);
    
    %Se crea un vector de resultados con todos los datos interesantes de la
    %calibración (valor de pixel acumulado en el area de la imagen con
    %spot, valor de pixel acumulado en el area de la imagen de corriente de
    %oscuridad, tiempo de apertura, ganancia, potencia en uW y cte. K)
    handles.resultsPotCal = {handles.spotPot ,handles.IoPot ,handles.src.ExposureTime ,handles.src.Gain ,1e3*handles.potFibermW ,handles.K}';
    
    %Se carga el vector de resultados en la tabla potCalResults, se
    %deshabilita el botón y se habilita el de reset de la calibración.
    set(handles.potCalResults,'data', handles.resultsPotCal);
    set(handles.calibratePot,'Enable', 'off');
    set(handles.restartPotCal,'Enable', 'on');
    set(handles.savePotCal,'Enable', 'on');
    
    %Actualizar la estructura handles.
    guidata(hObject, handles);
    
%Si hay un error, generar mensaje y resetear la calibración
catch exception
    h = msgbox('Error. Spot cant be found in image.','Spot not found','error');
    %¿Eliminar todos los campos de handles creados? Yo creo que sí
    %rmfield(handles, 'potFiberText');
    
    restartPotCal_Callback(hObject, eventdata, handles);
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in restartPotCal.
function restartPotCal_Callback(hObject, eventdata, handles)
% hObject    handle to restartPotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%¿Eliminar todos los campos de handles creados? Creo que sería necesario.
%rmfield(handles, 'potFiberText');

%Resetear todos los botones y textos al estado inicial.
set(handles.IoText,'String',handles.fixtext);
set(handles.potFiberText,'String', '');
set(handles.getImageIo,'Enable', 'on');
set(handles.getSpotImage,'Enable', 'off');
set(handles.potFiberText,'Enable', 'off');
set(handles.potFiberGet,'Enable', 'off');
set(handles.calibratePot,'Enable', 'off');
set(handles.restartPotCal,'Enable', 'off');

%Actualizar la estructura handles.
guidata(hObject, handles);

function potFiberText_Callback(hObject, eventdata, handles)
% hObject    handle to potFiberText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Función encargada de integrar la "potencia"(valor de pixel acumulado)
%en una imagen
function P = integrateImage(image)

% Integra la "potencia" en una imagen, es decir, obtiene el sumatorio de
% todos los pixeles en ella.
P = sum(sum(image));


% --- Executes when user attempts to close PotencyCalibrationUI.
function PotencyCalibrationUI_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to PotencyCalibrationUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

asd = 'asd'
set(handles.AjusteSatTA,'UserData', handles);
%Parar la Preview en ventana principal
stoppreview(handles.vid);

delete(hObject);


% --- Executes on button press in savePotCal.
function savePotCal_Callback(hObject, eventdata, handles)
% hObject    handle to savePotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PotencyCalibrationUI_CloseRequestFcn(PotencyCalibrationUI, eventdata, handles)
