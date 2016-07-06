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

% Last Modified by GUIDE v2.5 04-Jul-2016 19:26:34

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
%estructura handles de �sta. Se combinan las estructuras handles de ambas
%gui para trabajar con una �nica estructura de datos.
handles.mainFig = findobj('Tag','AjusteSatTA');
if ~isempty(handles.mainFig)
    data = guidata(handles.mainFig);
    handles = catstructmod(data, handles);
end
% Choose default command line output for PotencyCalibrationUI
handles.output = hObject;

%Se crea la cadena de texto fijo para el di�metro del spot.
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
function potFiberText1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to potFiberText1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function potFiberText2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to potFiberText2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function potFiberText1_Callback(hObject, eventdata, handles)

function potFiberText2_Callback(hObject, eventdata, handles)


%--------------------------------------------------------------------


% --- Executes on button press in getImageIo.
function getImageIo_Callback(hObject, eventdata, handles)
% hObject    handle to getImageIo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Se deshabilita el propio bot�n, se toma una imagen, y se calcula el nivel
%medio de los p�xeles en la imagen.
set(handles.getImageIo,'Enable', 'off');
handles.imageIo = getsnapshot(handles.vid);
handles.Io = sum(sum(handles.imageIo))/numel(handles.imageIo);

%Se obtiene el texto fijo y se concatena con el resultado obtenido.
handles.fixtext = get(handles.IoText,'String');
set(handles.IoText,'String', strcat(handles.fixtext, ' ', num2str(handles.Io,5)));

%Se habilita el siguiente bot�n (siguiente paso de la calibraci�n)
set(handles.getSpotImage1,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in getSpotImage1.
function getSpotImage1_Callback(hObject, eventdata, handles)
% hObject    handle to getSpotImage1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Deshabilitar el propio bot�n, capturar la imagen con el spot, habilitar el
%siguiente bot�n y su cajet�n de texto (siguiente paso de la calibraci�n).
set(handles.getSpotImage1,'Enable', 'off');
handles.imageSpot1 = getsnapshot(handles.vid);
set(handles.potFiberGet1,'Enable', 'on');
set(handles.potFiberText1,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in potFiberGet1.
function potFiberGet1_Callback(hObject, eventdata, handles)
% hObject    handle to potFiberGet1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Obtener el valor introducido en el cajet�n de texto potFiberText1
handles.potFiberdBm1 = str2double(get(handles.potFiberText1,'String'));

%Si no se introdujo nada o si no es un n�mero real se pone el cajet�n
%vac�o, se borra el campo de la estructura handles y se genera un mensaje
%de error.
if(isnan(handles.potFiberdBm1)||(~isreal(handles.potFiberdBm1)))
    set(handles.potFiberText1,'String', '');
    rmfield(handles, 'potFiberText1');
    h = msgbox('Error. Not a valid potency value. Must be a real number.','Invalid pot. value','error');
    
%Si el valor es un valor adecuado se deshabilitan el bot�n y el cajet�n de
%texto, se habilita el siguiente bot�n, y se adec�a el valor indicado al
%real en el plano de la punta de la fibra.
else
    set(handles.potFiberText1,'Enable', 'off');
    set(handles.potFiberGet1,'Enable', 'off');
    set(handles.getSpotImage2,'Enable', 'on');
    %Se resta la reflexi�n de Fresnel (Pot. trans. 96% de la incidente)
    handles.potFiberdBm1 = handles.potFiberdBm1 - 0.177;
    %Comprobar calculo con medidor de potencia del laser
    handles.potCalFibermW1 = (10^(handles.potFiberdBm1/10));
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in getSpotImage2.
function getSpotImage2_Callback(hObject, eventdata, handles)
% hObject    handle to getSpotImage2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Deshabilitar el propio bot�n, capturar la imagen con el spot, habilitar el
%siguiente bot�n y su cajet�n de texto (siguiente paso de la calibraci�n).
set(handles.getSpotImage2,'Enable', 'off');
handles.imageSpot2 = getsnapshot(handles.vid);
set(handles.potFiberGet2,'Enable', 'on');
set(handles.potFiberText2,'Enable', 'on');

%Actualizar la estructura handles.
guidata(hObject, handles);

% --- Executes on button press in potFiberGet2.
function potFiberGet2_Callback(hObject, eventdata, handles)
% hObject    handle to potFiberGet2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Obtener el valor introducido en el cajet�n de texto potFiberText1
handles.potFiberdBm2 = str2double(get(handles.potFiberText2,'String'));

%Si no se introdujo nada o si no es un n�mero real se pone el cajet�n
%vac�o, se borra el campo de la estructura handles y se genera un mensaje
%de error.
if(isnan(handles.potFiberdBm2)||(~isreal(handles.potFiberdBm2)))
    set(handles.potFiberText2,'String', '');
    rmfield(handles, 'potFiberText2');
    h = msgbox('Error. Not a valid potency value. Must be a real number.','Invalid pot. value','error');
    
%Si el valor es un valor adecuado se deshabilitan el bot�n y el cajet�n de
%texto, se habilita el siguiente bot�n, y se adec�a el valor indicado al
%real en el plano de la punta de la fibra.
else
    set(handles.potFiberText2,'Enable', 'off');
    set(handles.potFiberGet2,'Enable', 'off');
    set(handles.calibratePot,'Enable', 'on');
    %Se resta la reflexi�n de Fresnel (Pot. trans. 96% de la incidente)
    handles.potFiberdBm2 = handles.potFiberdBm2 - 0.177;
    %Comprobar calculo con medidor de potencia del laser
    handles.potCalFibermW2 = (10^(handles.potFiberdBm2/10));
end

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in calibratePot.
function calibratePot_Callback(hObject, eventdata, handles)
% hObject    handle to calibratePot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%I - Suma del valor de todos los p�xeles en la imagen del spot en el area
%con el 99% de potencia
%Io - Suma del valor de oscuridad de todos los p�xeles en la imagen de
%oscuridad en el area con el 99% de potencia (area de la imagen del spot
%obviamente)

try
    
    %Se obtiene el �rea de la imagen del spot que contiene el 99.999% de potencia
    %�Problema aqui? �99.999%?
    [handles.AOIcontourCal1, handles.maskCal1, handles.distCal1] = pottoareacircleUI(handles.imageSpot1, 99.999);
    [handles.AOIcontourCal2, handles.maskCal2, handles.distCal2] = pottoareacircleUI(handles.imageSpot2, 99.999);
    
    %Se obtienen los di�metros en X e Y del AOI y se genera la cadena de
    %caracteres para mostrar en la interfaz dichos datos
    diamx = max(handles.AOIcontourCal1(1,:)) - min(handles.AOIcontourCal1(1,:));
    diamy = max(handles.AOIcontourCal1(2,:)) - min(handles.AOIcontourCal1(2,:));
    string = strcat(handles.fixspotDiameterText, {' '}, num2str(diamx,3), ' pix (X)', {' '}, num2str(diamy,3), ' pix (Y)');
    set(handles.spotDiameterText, 'String', string);
    
    %Crear las im�genes s�lo con el AOI para integrar la potencia en ellas
    handles.AOIimageSpot1 = (double(handles.imageSpot1)).*(handles.maskCal1);
    handles.AOIimageSpot2 = (double(handles.imageSpot2)).*(handles.maskCal2);
    handles.AOIimageIo1 = (double(handles.imageIo)).*(handles.maskCal1);
    handles.AOIimageIo2 = (double(handles.imageIo)).*(handles.maskCal2);

    %Obtener la potencia en el AOI para las imagenes del spot(I1 e I2) y de
    %oscuridad(Io)
    handles.spotPot1 = integrateImage(handles.AOIimageSpot1);
    handles.spotPot2 = integrateImage(handles.AOIimageSpot2);
    handles.IoPot1 = integrateImage(handles.AOIimageIo1);
    handles.IoPot2 = integrateImage(handles.AOIimageIo2);
    
    %Vamos a probar las anonymous function y fsolve para resolver un
    %sistema no lineal en lugar de hacerlo con las ecuaciones obtenidas en
    %papel
    
    
    %Calcular "slope" (gamma en apuntes) sabiendo la potencia y el valor de
    %pixel en ambas im�genes. La f�rmula es la siguiente:
    % slope = ln((I1-Io)/(I2-Io))/ln(P1/P2)
    handles.slope = log((handles.spotPot1-handles.IoPot1)/(handles.spotPot2-handles.IoPot2))/log(handles.potCalFibermW1/handles.potCalFibermW2);
    
    % K = P(mW)*G*TA(s)/(I-Io)
    %handles.K = (handles.potFibermW)*(handles.src.Gain)*(1e6*(handles.src.ExposureTime))/(handles.spotPot-handles.IoPot);
    
    %Calcular la constante de calibraci�n K siguiendo la siguiente f�rmula:
    % K = (I-Io)/((P*TA)^slope)    
    handles.K1 = (handles.spotPot1-handles.IoPot1)/(((handles.potCalFibermW1)*(handles.src.Gain)*(1e-6*(handles.src.ExposureTime)))^handles.slope);
    handles.K2 = (handles.spotPot2-handles.IoPot2)/(((handles.potCalFibermW2)*(handles.src.Gain)*(1e-6*(handles.src.ExposureTime)))^handles.slope);
    handles.K = (handles.K1 + handles.K2)/2;
    
    %Se crea un vector de resultados con todos los datos interesantes de la
    %calibraci�n (valor de pixel acumulado en el area de la imagen con
    %spot, valor de pixel acumulado en el area de la imagen de corriente de
    %oscuridad, tiempo de apertura, ganancia, potencia en uW y cte. K)
    handles.resultsPotCal = {handles.potFiberdBm1, handles.potFiberdBm2, handles.spotPot1, handles.spotPot2, handles.IoPot1, handles.IoPot2, handles.K, handles.slope}';
    
    %Se carga el vector de resultados en la tabla potCalResultsTable, se
    %deshabilita el bot�n y se habilita el de reset de la calibraci�n.
    set(handles.potCalResultsTable,'data', handles.resultsPotCal);
    set(handles.calibratePot,'Enable', 'off');
    set(handles.restartPotCal,'Enable', 'on');
    set(handles.savePotCal,'Enable', 'on');
    set(handles.saveFilePotCal,'Enable', 'on');
    
    %Actualizar la estructura handles.
    guidata(hObject, handles);
    
%Si hay un error, generar mensaje y resetear la calibraci�n
catch exception
    h = msgbox('Error. Spot cant be found in image.','Spot not found','error');
    %�Eliminar todos los campos de handles creados? Yo creo que s�
    %rmfield(handles, 'potFiberText1');
    
    restartPotCal_Callback(hObject, eventdata, handles);
end

    %powerCalibrationFunction = @(x)[(handles.spotPot1-(x(1)*(handles.potCalFibermW1*1e6*(handles.src.ExposureTime))^x(2)+handles.IoPot1));
    %                                (handles.spotPot2-(x(1)*(handles.potCalFibermW2*1e6*(handles.src.ExposureTime))^x(2)+handles.IoPot2));
    %                                (handles.spotPot3-(x(1)*(handles.potCalFibermW3*1e6*(handles.src.ExposureTime))^x(2)+handles.IoPot1))];
    % 
    %[x,fval] = fsolve(powerCalibrationFunction, [1 1])

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in restartPotCal.
function restartPotCal_Callback(hObject, eventdata, handles)
% hObject    handle to restartPotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%�Eliminar todos los campos de handles creados? Creo que ser�a necesario.
%rmfield(handles, 'potFiberText1');

%Resetear todos los botones y textos al estado inicial.
set(handles.IoText,'String',handles.fixtext);
set(handles.potFiberText1,'String', '');
set(handles.potFiberText2,'String', '');
set(handles.potFiberText3,'String', '');
set(handles.getImageIo,'Enable', 'on');
set(handles.getSpotImage1,'Enable', 'off');
set(handles.potFiberText1,'Enable', 'off');
set(handles.potFiberGet1,'Enable', 'off');
set(handles.getSpotImage2,'Enable', 'off');
set(handles.potFiberText2,'Enable', 'off');
set(handles.potFiberGet2,'Enable', 'off');
set(handles.getSpotImage3,'Enable', 'off');
set(handles.potFiberText3,'Enable', 'off');
set(handles.potFiberGet3,'Enable', 'off');
set(handles.calibratePot,'Enable', 'off');
set(handles.restartPotCal,'Enable', 'off');

%Actualizar la estructura handles.
guidata(hObject, handles);


% --- Executes on button press in savePotCal.
function savePotCal_Callback(hObject, eventdata, handles)
% hObject    handle to savePotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

PotencyCalibrationUI_CloseRequestFcn(PotencyCalibrationUI, eventdata, handles)


% --- Executes on button press in saveFilePotCal.
function saveFilePotCal_Callback(hObject, eventdata, handles)
% hObject    handle to saveFilePotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

calType = 'Power';
imageIo = handles.imageIo;
imageSpot1 = handles.imageSpot1;
imageSpot2 = handles.imageSpot2;
potFiberdBm1 = handles.potFiberdBm1;
potFiberdBm2 = handles.potFiberdBm2;
uisave({'calType','imageIo','imageSpot1','potFiberdBm1','imageSpot2','potFiberdBm2'},'PowerCalibrationVars');

guidata(hObject, handles);


% --- Executes on button press in loadFilePotCal.
function loadFilePotCal_Callback(hObject, eventdata, handles)
% hObject    handle to loadFilePotCal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    [handles.fileName,handles.filePath ]= uigetfile('*.mat');
    handles.fileFullPath = fullfile(handles.filePath, handles.fileName);
    load(handles.fileFullPath);
    
    if(~exist('calType')||(~strcmp(calType,'Power')))
        throw(exception);
    else
        %Cargar variables a estructura handles
        handles.imageIo = imageIo;
        handles.imageSpot1 = imageSpot1;
        handles.potFiberdBm1 = potFiberdBm1;
        handles.imageSpot2 = imageSpot2;
        handles.potFiberdBm2 = potFiberdBm2;
        %No se resta la reflexi�n de Fresnel(ya restada cuando se guard�)
        %Comprobar calculo con medidor de potencia del laser
        handles.potCalFibermW1 = (10^(handles.potFiberdBm1/10));
        handles.potCalFibermW2 = (10^(handles.potFiberdBm2/10));
    end
    
    %Texto "Dark current pixel value:"
    handles.Io = sum(sum(handles.imageIo))/numel(handles.imageIo);
    %Se obtiene el texto fijo y se concatena con el resultado obtenido.
    handles.fixtext = get(handles.IoText,'String');
    set(handles.IoText,'String', strcat(handles.fixtext, ' ', num2str(handles.Io,5)));
    
    %Calibraci�n
    calibratePot_Callback(handles.calibratePot, eventdata, handles);
    handles = guidata(handles.calibratePot);
    
    %Habilitar y deshabilitar lo que corresponda
    set(handles.getImageIo,'Enable', 'off');
    set(handles.getSpotImage1,'Enable', 'off');
    set(handles.potFiberText1,'Enable', 'off');
    set(handles.potFiberGet1,'Enable', 'off');
    set(handles.getSpotImage2,'Enable', 'off');
    set(handles.potFiberText2,'Enable', 'off');
    set(handles.potFiberGet2,'Enable', 'off');
    set(handles.calibratePot,'Enable', 'off');
    set(handles.restartPotCal,'Enable', 'on');
    set(handles.savePotCal,'Enable', 'on');
    set(handles.saveFilePotCal,'Enable', 'on');
    
catch exception
    h = msgbox('Error. Power calibration error. Invalid file or file content.','Power Calibration File Error','error');
end

guidata(hObject, handles);


% --- Funci�n encargada de integrar la "potencia"(valor de pixel acumulado)
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
if(isfield(handles, 'AjusteSatTA'))
    set(handles.AjusteSatTA,'UserData', handles);
end
%Parar la Preview en ventana principal
if(isfield(handles, 'vid'))
    stoppreview(handles.vid);
end

delete(hObject);
