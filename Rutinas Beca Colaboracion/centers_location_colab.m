% function [centers, radii] = centers_location_colab(image)
%
% Función que detecta las circunferencias en el array de imágenes y guarda
% la posición del centro de la circunferencia y del radio estimado para
% cada imagen.
% Si la circunferencia no se detecta, las coordenadas del centro y el valor
% del radio se ponen al mismo valor que para la imagen anterior.
% La función también representa los distintos puntos en los que se
% posiciona el centro en una gráfica.
%
% Parámetros de entrada
%
% images   Imagen a analizar
%
%
% Parámetros de salida
%
% centers   Vector con dos valores, uno para la coordenada
% X y otro para la coordenada Y de cada circunferencia.
%
% radii     Vector con el valor del radio estimado para cada circunferencia.

function [centers, maxpix] = centers_location_colab(image)

warning off all;
radiusrange = [10 100];
centers = imfindcircles(image, radiusrange);
maxpix = double(image(round(centers(2)), round(centers(1))));