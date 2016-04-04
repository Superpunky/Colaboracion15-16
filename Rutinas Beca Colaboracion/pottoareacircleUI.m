%function rect = pottoareaUI(image, P)
%

function [AOI_contorno,mascara,dist] = pottoareaUI(image, P, axes)

%Definir vectores de los ejes de la imagen.
x = 1:1:size(image,2);
y = 1:1:size(image,1);

%Localizar los centros en la imagen y obtener sus coordenadas (medias de
%las distribuciones) y el valor de dichos p�xeles.
[mu, maxpix] = centers_location_colab(image);


%Con los datos obtenidos, llamar a una funci�n que realiza el ajuste de la
%superficie gaussiana. Se obtienen el valor de ruido de fondo y las
%desviaciones t�picas de las distribuciones en X y en Y.
[backnoise, sigmax, sigmay] = gaussimagefit(image, mu(1), mu(2), maxpix);

%Se llama a una funcion para calcular la mascara de integraci�n necesaria
%para integrar en un area en el cual la integral de una funcion Normal
%(Gaussiana) bidimensional contenga una fraccion determinada de su
%integral. Se obtiene la m�scara de integraci�n y los valores de los
%p�xeles de contorno en X y en Y.
[x_contorno,y_contorno,mascara]=mascara_integracion_gauss(x,y,mu(1),sigmax,mu(2),sigmay,P/100);
AOI_contorno = [x_contorno; y_contorno];

%Se agrupan todos los datos calculados en una estructura llamada dist. que
%es uno de los par�metros de salida, junto con la m�scara y el contorno del
%AOI.
dist.maxpix = maxpix;
dist.backnoise = backnoise;
dist.mux = mu(1);
dist.muy = mu(2);
dist.sigmax = sigmax;
dist.sigmay = sigmay;