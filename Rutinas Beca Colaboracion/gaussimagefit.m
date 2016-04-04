%function [backnoise, sigmax, sigmay] = gaussimagefit(image, mux, muy, maxpix)
%
%Funci�n que realiza el ajuste de la superficie gaussiana con los datos de
%una imagen de la c�mara IR, es decir, monocrom�tica de 320x256 p�xeles.
%
%Par�metros de entrada
%
%   image   Imagen a la que se va a realizar el ajuste
%   mux     Media en x de la dist. gaussiana, es decir, coordenada x del
%   pixel con valor m�ximo en la imagen
%   muy     Media en y de la dist. gaussiana, es decir, coordenada y del
%   pixel con valor m�ximo en la imagen
%   maxpix  Valor del pixel con valor m�ximo en la imagen
%
%Par�metros de salida
%
%   backnoise   Estimaci�n del valor de ruido de fondo en la imagen
%   (p�xeles del fondo)
%   sigmax      Estimaci�n de la desviaci�n t�pica en x para la dist.
%   gaussiana
%   sigmay      Estimaci�n de la desviaci�n t�pica en y para la dist.
%   gaussiana

function [backnoise, sigmax, sigmay] = gaussimagefit(image, mux, muy, maxpix)


%expr = 'image = (maxpix-backnoise)*exp(-(x-mux)^2/(2*sigmax^2)-(y-muy)^2/(2*sigmay^2))+backnoise';

[ymax xmax] = size(image);
y = 1:ymax; x = 1:xmax;


%Creaci�n del objeto fittype para indicar el tipo de fit que se va a hacer,
%en nuestro caso con una 'Custom Equation'.

ffun2 = fittype( 'maxpix*exp(-(X-mux).^2/(2*sigmax^2)-(Y-muy).^2/(2*sigmay^2))+backnoise',...
    'independent', {'X', 'Y'}, 'dependent', 'Z',...
    'problem', {'maxpix', 'mux', 'muy'});

%Adaptaci�n de los datos al formato adecuado para el fit

[X, Y, Z]= prepareSurfaceData(x,y,image);

%Ejecuci�n del fit, indicando los par�metros dependientes del problema

fitobject = fit([X,Y],Z, ffun2, 'problem', {maxpix, mux, muy});

%Adquisici�n de los valores ajustados

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