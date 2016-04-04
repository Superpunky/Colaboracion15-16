function Dibuja_circulos_interactivos_prueba
% Prueba de la rutina Dibuja_circulos_interactivos
% Se puede comprobar que si se teclea en la consola Matlab 
%
%      get(gcf,'UserData')
%
% en cualquier momento nos devuelve el conjunto vacio mientras que cuando se ha terminado 
% de ejecutar (pulsando una tecla despues de haber definido un circulo nos devuelve el ultimo valor del radio y la posicion del centro.

clear

% ********************************************** Dibuja una Gaussian bidimensional en una figura ***********************************************************
% Media y desviacion típica de la Gaussiana
x0=-0.5;
Sig_x=0.67;
y0=2;
Sig_y=1.5;

% Define los ejes
x_max=6;
x_min=-6;
dx=0.1;
y_max=6;
y_min=-6;
dy=0.2;
x=x_min:dx:x_max;
y=y_min:dy:y_max;

% Calcula las matrices de X e Y para definir la superficie sobre la que se
% dibuja
[X,Y] = meshgrid(x, y);

% Define la gaussiana normlizada (area bajo la curva unidad)  y la dibuja
% en una figura
z_gauss =1/(2*pi*Sig_x*Sig_y) *exp(-1/2*(((X-x0)/Sig_x).^2 +((Y-y0)/Sig_y).^2));
Fig1=figure(1); contourf(x,y,z_gauss); grid; colorbar;


Dibuja_circulos_interactivos


