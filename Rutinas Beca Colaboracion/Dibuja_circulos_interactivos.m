function Dibuja_circulos_interactivos_bis
% Es una subrutina que permite dibujar una circunferencia en la ventana activa y
% luego cambiarle la posicion del centro y su radio de forma grafica
% (pinchando en el centro o en la circunferencia y arrastrando con el
% raton). Se sale de esta funcion pulsando una tecla.  La tecla 'escape' borra el circulo y no graba los datos del
% centro y radio. Cualquier otra tecla deja el circulo en pantalla y graba
% los valores de centro y radio.
%Se puede obtener la posicion del centro y el radio de la
% circunferencia en la variable UserData de la figura: Por ejemplo teniendo la ventana activa y ejecutando: 
%
% get(gcf,'UserData')
%

Flag_ButtonDown=0;   % Flag para controlar si es la primera vez que se pulsa el boton sobre la figura o no
teta=linspace(0,2*pi,50);  % Vector de angulos para dibujar circulos

Fig1=gcf;   % Coge el handle a la figura actual
Ax1=gca;   % Coge el handle a los ejes actuales
figure(Fig1);  %Trae la figura al frente

% Se calcula 
%       1. El centro de la circunferencia para  estar en medio de la pantalla y que al defirla al principio no reescale los ejes 
%        2. El radio de la primera circunferencia que se va a pintar para que sea un 1/20 del tamaño del eje mas pequeño
Xlimits=get(Ax1, 'Xlim');
Ylimits=get(Ax1, 'Ylim');
Axes_size=min(abs(diff(Xlimits)), abs(diff(Ylimits)));
r=Axes_size/20;        % Se calcula el radio a 1/20 del tamaño minimo de los ejes
Zo=(Xlimits(1)+Xlimits(2))/2+j*(Ylimits(1)+Ylimits(2))/2; % Fija Zo al centro de la grafica
 
%Crea los objetos Centro y Circulo pero no los dibuja
Centro=line([real(Zo)],[imag(Zo)],'color', 'black','linewidth', 2, 'linestyle', 'none');
Circulo=line(real(Zo),imag(Zo),'color', 'black','linewidth', 2, 'linestyle', 'none');

set(Fig1,'WindowButtonDownFcn', @ButtonDownFcn_Figure); % Activa la funcion de deteccion de click del raton sobre la Figura
set(Centro,'ButtonDownFcn', @startDragFcn_Centro);  % Activa la funcion de deteccion de click del raton sobre el Centro
set(Circulo,'ButtonDownFcn', @startDragFcn_Circulo);   % Activa la funcion de deteccion de click del raton sobre el Circulo 
set(Fig1,'keypressfcn',@lee_tecla);   % Activa la funcion de deteccion de que se pulsa el teclado cuando se esta sobre la figura

 % Funcion activada cuando se pulsa sobre la Figura
     function ButtonDownFcn_Figure(varargin)
        % Callback que se ejecuta cuando se presiona el raton sobre la figura por primera vez (no sobre un objeto específico de la figura)
        if Flag_ButtonDown==0        % Verifica que es la primera vez que se pulsa el raton sobre la figura
            Flag_ButtonDown=1;         % Pone el flag a uno
            pt=get(Ax1,'currentpoint');                              % Lee la posicion del mouse sobre los ejes
            x0=pt(1,1); y0=pt(2,2);
            % Verifica que el circulo se pinte dentro de los ejes
            x0=min(x0,Xlimits(2)-r);
            x0=max(x0,Xlimits(1)+r);
            y0=min(y0,Ylimits(2)-r);
            y0=max(y0,Ylimits(1)+r);
            Zo=x0+j*y0;                % Calcula la posicion del centro en el plano complejo
            Z=Zo+r*exp(j*teta);    % Calcula la circunferencia  
            % Dibuja la circunferencia y su centro
            set(Circulo,'Xdata',[real(Z)],'Ydata', [imag(Z)],'linestyle', '-');
            set(Centro,'Xdata',[real(Zo)],'Ydata', [imag(Zo)],'Marker','+','MarkerSize',8);            
        end
     end
 
 % Funciones activadas cuando se pulsa sobre el Centro
    function startDragFcn_Centro(varargin)
        % Callback que se ejecuta cuando se pulsa el mouse sobre el objeto Centro
        set(Fig1,'WindowButtonMotionFcn', @draggingFcn_Centro);  
        set(Fig1,'WindowButtonUpFcn', @stopDragFcn);                      
    end
    function draggingFcn_Centro(varargin)
        % Callback que se ejecuta cuando se mueve el raton sobre la ventana
        % despues de haber pulsado sobre el objeto Centro
        pt=get(Ax1,'currentpoint');                              % Lee la posicion del mouse sobre los ejes
        x0=pt(1,1); y0=pt(2,2); Zo=x0+j*y0;                % Calcula la posicion del centro en el plano complejo
        set(gco,'Xdata',[x0],'Ydata', [y0],'linestyle', '-');                     % Situa el objeto actual (el Centro) en la posicion del cursor
        %  Recalcula el circulo para que se mueva con el Centro
        Z=Zo+r*exp(j*teta);
        set(Circulo,'Xdata',[real(Z)],'Ydata', [imag(Z)],'linestyle', '-');
        %
    end

% Funciones activadas cuando se pulsa sobre el Circulo
    function startDragFcn_Circulo(varargin)
        % Callback que se ejecuta cuando se pulsa el mouse sobre el objeto Circulo
        %set(gco,'color', 'blue');
        set(Fig1,'WindowButtonMotionFcn', @draggingFcn_Circulo);
        set(Fig1,'WindowButtonUpFcn', @stopDragFcn);
    end
    function draggingFcn_Circulo(varargin)
        % Callback que se ejecuta cuando se mueve el raton sobre la ventana
        % despues de haber pulsado sobre el objeto Circulo
        pt=get(Ax1,'currentpoint');                              % Lee la posicion del mouse sobre los ejes
        xm=pt(1,1); ym=pt(2,2); Zm=xm+j*ym;                % Calcula la posicion del mouse (borde del circulo) en el plano complejo
        r=abs(Zo-Zm);                                                  % Calcula el radio de la nueva circunferencia
        %  Recalcula el Circulo con su nuevo radio
        Z=Zo+r*exp(j*teta);
        set(gco,'Xdata',[real(Z)],'Ydata', [imag(Z)]);
        %Circulo=line(real(Z),imag(Z),...
        %    'color', 'red',...
        %  'linewidth', 2);
        %
    end

 % Funcion activada cuando se suelta el boton del raton sobre cualquiera de los objetos (Figura, Centro o Circulo
    function stopDragFcn(varargin)
        % Callback que se ejecuta cuando se suelta el boton del mouse sobre la ventana
        set(Fig1,'WindowButtonMotionFcn','');   % Deshabilita el callback que se ejecuta cuando se mueve el cursor sobre la ventana 
    end

% Funcion activada cuando se pulsa el teclado para salir
    function tecla=lee_tecla(hObject, callbackdata)
        % Cancela la llamada a todos los callbacks llamados por el mouse o el keyboard 
        set(Fig1,'keypressfcn','')
        set(Fig1,'WindowButtonDownFcn','');
        set(Centro,'ButtonDownFcn','');
        set(Circulo,'ButtonDownFcn','');
        
        tecla=get(hObject,'currentkey'); % Captura la tecla que se ha pulsado.  Si se pulsa la tecla escape se borra el circulo y no se guardan los datos de radio y centro
        %  para cualquier otra tecla se guardan los datos y no se borra el circulo
        if strcmp(tecla,'escape')
            delete (Centro)
            delete (Circulo)
        else
            if Flag_ButtonDown==1
                set(Fig1,'UserData', struct('Centro', Zo, 'Radio', r));  % Guarda el centro y el radio del circulo en una estructura de datos (se puede recuperar esta estructura de datos
                %desde fuera de esta subrutina mediante la instruccion get(gcf,'UserData') una vez que la ventana que contiene el circulo
                % es la ventana activa
                %get(Fig1,'UserData')
            end
        end
    end

end