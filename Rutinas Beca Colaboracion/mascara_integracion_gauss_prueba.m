% Programa de prueba para la funcion 'mascara_integracion_gauss.m'
%


clear

% Media y desviacion típica de la Gaussiana
x0=-0.5;
Sig_x=2;
y0=3;
Sig_y=1;

%Fraccion del area que se quiere integrar
porcentaje_integrac=0.2;

% Define los ejes
x_max=6;
x_min=-6;
dx=0.1;
y_max=6;
y_min=-6;
dy=0.2;
x=x_min:dx:x_max;
y=y_min:dy:y_max;

% LLama a la rutina para calcular la mascara y el contorno de integración
% (la rutina que se quiere probar
[x_contorno,y_contorno,Mascara]=mascara_integracion_gauss(x,y,x0,Sig_x,y0,Sig_y,porcentaje_integrac);

% Calcula las matrices de X e Y para definir la superficie sobre la que se
% dibuja
[X,Y] = meshgrid(x, y);

% Define la gaussiana normlizada (area bajo la curva unidad) y calcula la
% gaussiana enmascarada
z_gauss =1/(2*pi*Sig_x*Sig_y) *exp(-1/2*(((X-x0)/Sig_x).^2 +((Y-y0)/Sig_y).^2));
z_gauss_enmascarada=z_gauss.*Mascara;


%Calcula las integrales bajo la curva
int_tot=sum(sum(z_gauss))*dx*dy  % Calculala integral total de la gaussiana en todo el plano x,y
int_zona=sum(sum(z_gauss_enmascarada))*dx*dy % Calculala integral de la gaussiana bajo la mascara

% Dibuja la Gaussiana la Mascara  y la Gaussiana enmascarada
figure(1); surf(X,Y,z_gauss); xlabel('x'); ylabel('y'); grid
title('Gaussiana normalizada para integral unidad')
figure(2); surf(X,Y,Mascara); xlabel('x'); ylabel('y'); grid
title('Mascara de integracion')
figure(3); surf(X,Y,z_gauss_enmascarada); xlabel('x'); ylabel('y'); grid
title('Gaussiana enmascarada para que contenga el porcentaje del area deseado')

% Dibuja la curva de contorno que define la zona dentro de la cual se va a
% integrar y la fraccion de
figure(4)
contourf(x,y,z_gauss); colorbar; hold on
plot(x_contorno,y_contorno,'--k', 'LineWidth',3);grid;
axis([x_min x_max y_min y_max])
axis('square'); xlabel('x'); ylabel('y')
hold off
titulo=['Fraccion de la integral en el area punteada frente a la integral total=' num2str(100*int_zona/int_tot) '%'];
title(titulo)
