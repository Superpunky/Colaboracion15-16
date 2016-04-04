% function [images, images_info] = read_images_2(path, format)
%
% Lee un conjunto de imágenes del mismo formato almacenadas en el mismo
% directorio. Devuelve una matriz con todas las imágenes (images) y un
% una estructura con información de la imagen para cada una de ellas.
% Entre la información de la estructura se encuentra el nombre del archivo.
% Lee las imágenes suponiendo un tamaño de 320x256 
% (Cámara IR Goldeye P-008 SWIR)
%
% path       Ruta en la que se encuentran los archivos de imagen
% format     Formato de las imágenes, a indicar como '.jpg', '.tiff',
% etc...


function [images, images_info] = read_images_2(path, format)

format = strcat('*', format);

images_info = dir([path format]);

images = zeros(256, 320, length(images_info));
%names = images_info(:).name;
for i=1:length(images_info)
    images(:,:,i) = imread([path images_info(i).name]);
end

escalado = 2^12/2^16;
for n=1:length(images_info);
    for i=1:256;
        for j=1:320;
            images(i,j,n) = images(i,j,n)*escalado;
        end
    end
end
    