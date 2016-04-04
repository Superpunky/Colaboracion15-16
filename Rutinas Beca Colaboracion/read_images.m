% function A = read_images(fix_name, num_img, format)
%
% Lee un conjunto de imágenes almacenadas en el mismo directorio con un
% nombre común excepto por un número al final del nombre que diferencia las
% imágenes.
% fix_name   Parte fija del nombre de los archivos de imagen
% num_img    Número de imágenes, que indica hasta qué número habrá que leer
% imágenes, empezando por 1 (fix_name1.xxx)
% format     Formato de las imágenes, a indicar como '.jpg', '.tiff',
% etc...
% Se puede usar para imágenes almacenadas en un directorio diferente del de
% trabajo si fix_name indica la ruta a los archivos además de la parte fija
% del nombre. Por ejemplo, en lugar de ser "IMG_", puede ser
% "/imagenes/IMG_", y así el directorio de trabajo puede ser el directorio
% en el que está almacenada la carpeta imagenes.

function A = read_images(fix_name, num_imgs, format)

escalado = 2^12/2^16;
img = imread(strcat(fix_name,'1',format));
[X, Y] = size(img);
A = zeros(X, Y, num_imgs);
A(:,:,1)=img;
for i=1:size(img,1);
    for j=1:size(img,2);
        A(i,j,1) = A(i,j,1)*escalado;
    end
end
for n=2:num_imgs;
    img = imread(strcat(fix_name,num2str(n),format));
    A(:,:,n) = img;
    for i=1:size(img,1);
        for j=1:size(img,2);
            A(i,j,n) = A(i,j,n)*escalado;
        end
    end
end
    