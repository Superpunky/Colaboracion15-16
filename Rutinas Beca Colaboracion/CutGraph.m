function CutGraph(image, varargin)
%CUTGRAPH Muestra en una gráfica los valores de los píxeles de una línea o 
%columna de una imagen.
%   CutGraph(image) representa los valores de la linea situada a la mitad
%   de la altura de la imagen.
%
%   CutGraph(image, 'h'), CutGraph(image, 'v') representa los valores de la
%   linea y la columna, respectivamente, situada a la mitad de altura o
%   anchura de la imagen.
%
%   CutGraph(image, 100) representa los valores de la linea número 100 de
%   la imagen.
%
%   CutGraph(image, 'v', 150) representa los valores de la columna número
%   150 de la imagen.


[y x] = size(image);
chararg = 'h';
numarg = 0;
Y = (1:y);
X = (1:x);


if (nargin > 3)
    error('Too many input arguments. Max is 3')
elseif(nargin > 1)
    nchararg = 0;
    nnumarg = 0;
    for k = 1:(nargin-1)
        if (strcmp(class(varargin{k}),'char'))
            nchararg = nchararg +1;
            chararg = varargin{k};
        elseif (strcmp(class(varargin{k}),'double'))
            nnumarg = nnumarg + 1;
            numarg = varargin{k};
        else
            error('Invalid optional argument class. Valid optional argument classes: double or char')
        end
        if (nchararg > 1)||(nnumarg > 1)
            error('Just 1 char argument and 1 double argument allowed')
        end
    end
end
if (chararg == 'h')
    if(numarg == 0)
        numarg = round(y/2);
    end
    cut = numarg;
    if(cut > y)
        error('Image size (%dX%d) exceeded', x, y)
    end
    cutdata = image(cut,:);
    figure; plot(X, cutdata);
elseif (chararg == 'v')
    if(numarg == 0)
        numarg = round(x/2);
    end
    cut = numarg;
    if(cut > x)
        error('Image size (%dX%d) exceeded', x, y)
    end
    cutdata = image(:,cut);
    figure; plot(Y, cutdata);
else
    error('Invalid char argument. Just ''h'' and ''v'' are valid char arguments')
end

end

