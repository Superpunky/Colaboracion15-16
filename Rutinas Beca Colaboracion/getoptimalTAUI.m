%function TA = getoptimalTAUI(handles)
%
%   Primera versi�n. Ajuste grueso. Saltos de x2 o /2 desde 1ms de TA
%   Condici�n de saturaci�n: ultimos cuatro contadores del hist con menos
%   de 3 ocurrencias (pixeles).
%

function TA = getoptimalTAUI(handles)

TAo = 1000;
TA = TAo;                                           %Actualizar TA
handles.src.ExposureTime = TA;                      %Modificar TA de la c�mara
handles.image = getdata(handles.vid,1);                   %Tomar imagen
rect = pottoarea(handles.image, 90);                        %Encontrar rect�ngulo de pot 90%
AOI = handles.image(handles.rect(2):(handles.rect(2)+handles.rect(4)),handles.rect(1):(handles.rect(1)+handles.rect(3))); %Generar imagen solo con AOI 90% pot
[count x] = imhist(AOI);                                    %Hacer histograma y cuenta ocurrencias por bin       
sat = ((count(253)+count(254)+count(255)+count(256))<3);    %Saturado si pixeles en los ultimos 4 bins (valor mayor que 4032 de 4096) mayor que 2

if(sat)                                                     %Si con TAo saturado
    mult = 0.5;                                             %Progresi�n hacia TA menor (mitad)
    endifsat = 0;                                           %Dejar de buscar cuando no se est� saturado
else                                                        %Si con TAo no saturado
    mult = 2;                                               %Progresi�n hacia TA mayor (doble)
    endifsat = 1;                                           %Dejar de buscar cuando se est� saturado
end

while(sat != endifsat)                                      %Mientras no se cumpla la condici�n para dejar de buscar, bucle
    TA = TA*mult;
    handles.src.ExposureTime = TA;
    handles.image = getdata(handles.vid,1);
    AOI = handles.image(handles.rect(2):(handles.rect(2)+handles.rect(4)),handles.rect(1):(handles.rect(1)+handles.rect(3)));
    [count x] = imhist(AOI);
    sat = ((count(253)+count(254)+count(255)+count(256))<3);
end

if(endifsat)
    TA =TA/mult;
end