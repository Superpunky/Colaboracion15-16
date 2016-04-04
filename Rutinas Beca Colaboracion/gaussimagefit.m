%function [backnoise, sigmax, sigmay] = gaussimagefit(image, mux, muy, maxpix)
%
%Función que realiza el ajuste de la superficie gaussiana con los datos de
%una imagen de la cámara IR, es decir, monocromática de 320x256 píxeles.
%
%Parámetros de entrada
%
%   image   Imagen a la que se va a realizar el ajuste
%   mux     Media en x de la dist. gaussiana, es decir, coordenada x del
%   pixel con valor máximo en la imagen
%   muy     Media en y de la dist. gaussiana, es decir, coordenada y del
%   pixel con valor máximo en la imagen
%   maxpix  Valor del pixel con valor máximo en la imagen
%
%Parámetros de salida
%
%   backnoise   Estimación del valor de ruido de fondo en la imagen
%   (píxeles del fondo)
%   sigmax      Estimación de la desviación típica en x para la dist.
%   gaussiana
%   sigmay      Estimación de la desviación típica en y para la dist.
%   gaussiana

function [backnoise, sigmax, sigmay] = gaussimagefit(image, mux, muy, maxpix)


%expr = 'image = (maxpix-backnoise)*exp(-(x-mux)^2/(2*sigmax^2)-(y-muy)^2/(2*sigmay^2))+backnoise';

[ymax xmax] = size(image);
y = 1:ymax; x = 1:xmax;


%Creación del objeto fittype para indicar el tipo de fit que se va a hacer,
%en nuestro caso con una 'Custom Equation'.

ffun2 = fittype( 'maxpix*exp(-(X-mux).^2/(2*sigmax^2)-(Y-muy).^2/(2*sigmay^2))+backnoise',...
    'independent', {'X', 'Y'}, 'dependent', 'Z',...
    'problem', {'maxpix', 'mux', 'muy'});

%Adaptación de los datos al formato adecuado para el fit

[X, Y, Z]= prepareSurfaceData(x,y,image);

%Ejecución del fit, indicando los parámetros dependientes del problema

fitobject = fit([X,Y],Z, ffun2, 'problem', {maxpix, mux, muy});

%Adquisición de los valores ajustados

values = coeffvalues(fitobject);
backnoise = values(1);
sigmax = values(2);
sigmay = values(3);

%@(pixmax, sigmax, sigmay, backnoise, X, Y)...
%'coefficients', {'sigmax', 'sigmay', 'backnoise'}

%ffun = fittype(expr, 'independent', {'x', 'y'});

%g = fittype( @(a, b, c, d, x, y) a*x.^2+b*x+c*exp...
%    ( -(y-d).^2 ), 'independent', {'x', 'y'},...
%    'dependent', 'z' );