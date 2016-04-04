function [x_contorno,y_contorno,mascara]=mascara_integracion_gauss(x,y,mu_x,sig_x,mu_y,sig_y,fracc_integr)
%
% Funcion para calcular la mascara de integración necesaria para integrar
% en un area en el cual la integral de una funcion Normal (Gaussiana)
% bidimensional contenga una fraccion determinada de su integral
%
% ENTRADAS
    %     x--> Eje x equiespaciado
    %     y--> Eje y equiespaciado
    %    mu_x --> Posicion del centro de la gaussiana en eje x
    %    sig_x --> Desviación típica de la gaussiana en el eje x
     %   mu_y --> Posicion del centro de la gaussiana en eje y
    %    sig_y--> Desviación típica de la gaussiana en el eje y
    %    fracc_integr--> fraccion del area bajo la curva que se quiere tener en la zona de integracion
% SALIDAS
    %     x_contorno-->Variable x de la curva de contorno que delimita la región de integración
    %     y_contorno-->Variable y de la curva de contorno que delimita la región de integración
    %     mascara ---> Mascara de integración (Matriz con 1s en la zona de integracion y 0s en la zona donde no hay que integrar)

% Calcula las matrices de X e Y para definir la superficie
[X,Y] = meshgrid(x, y);

% Define la gaussiana normlizada (area bajo la curva unidad)
z_gauss =1/(2*pi*sig_x*sig_y) *exp(-1/2*(((X-mu_x)/sig_x).^2 +((Y-mu_y)/sig_y).^2));

% Calcula la altura aproximada (altura de la curva de nivel) para tener una cierta potencia si se integra
% para valores mayores de esa altura
altura=1/(2*pi*sig_x*sig_y)*(1-fracc_integr);

% Encuentra la linea de contorno (curva de nivel) para la cual z_gauss=Altura
figure(222)
[contor_alt,h]=contour(X,Y,z_gauss,[altura altura]); % llama a la funcion contour para encontrar la linea de contorno del valor deseado
close (222)
contor_alt(:,1)=[];   % Elimina la primera columna que indica el valor deseado y el numero de puntos del contorno
x_contorno=contor_alt(1,:);
y_contorno=contor_alt(2,:);

% Genera la mascara que identifica la region del plano x-y donde la
% gaussiana es mayor que el valor  de la altura indicada
mascara=z_gauss>altura;
mascara=mascara.*ones(size(mascara)); % Esto sirve para convertir la variable logica a numerica



