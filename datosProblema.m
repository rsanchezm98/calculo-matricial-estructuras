%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Datos del sistema
% Fecha: 23/01/2021
% Orden: 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format short % especificamos la precision que queremos que nos muestre por pantalla

addpath('funciones/'); % añadimos las funciones al path de trabajo

ident =  [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12]; % identificador de las barras
origen = [1; 1; 3; 5; 5; 3; 5; 5; 7; 1; 1; 7]; % nudo origen de las barras
fin =    [3; 2; 2; 3; 4; 4; 7; 6; 6; 7; 8; 8]; % nudo fin de las barras
numNudos = 8; % numero de nudos del sistema 

EA = [8.26; 8.26;8.26;8.26;8.26;8.26;8.26;8.26;8.26;8.26;8.26;8.26]; % EA de cada barra (EA/EI en realidad si todo va a ir en funcion de EI)
EI = [1;1;1;1;1;1;1;1;1;1;1;1]; % EI dejarlo a 1 si es todo en referencia de EI
% si dan el valor de EA y EI meter EA y EI respectivamente
L = [1.1*sqrt(2);1.1;1.1;1.1*sqrt(2);1.1;1.1;1.1*sqrt(2);1.1;1.1;1.1*sqrt(2);1.1;1.1]; % L de las barras
alfa = [180-45; 90; 0; 45;90;180;-45;-90;180;180+45;-90;0]; % angulos

% tipos 'artRig', 'rigArt', 'articuladas', 'rigidas'
tipo = {'rigArt'; 'rigidas'; 'artRig';'rigArt';'rigidas';'artRig';'rigArt';'rigidas';'artRig';'rigArt';'rigidas';'artRig'};

% ojo cada nudo es 3*3 luego tenlo en cuenta para poner su indice
% ejemplo quiero el desplazamiento horizontal del nudo 3 luego tengo que poner el 3+3+1
% = 7. Si es el v3 entonces es 3*2 + 2 [3*(n-1)+1-2-3]
desp = [2,3,6,8,12,14,15,18,20,24]; %% desplazamientos objetivos
despIndependientes = [2,3,6,8]; % desplazamientos independientes para la matriz reducida
despNoIndependientes = [12,14,15,18,20,24]; % desplazamientos no independientes del sistema
relacionesIndependientesNoIndependientes = [-3,1,-2,-3,4,3]; % se refiere a la posición
% del vector desp con el signo que le corresponde por ejemplo: el 7 es el
% negativo del desplazamiento 4, luego su valor en este vector es - 1

% creación de tabla con los datos
tablaConex = table(ident,origen,fin,tipo,EA,EI,L,alfa);

% mostramos la tabla por pantalla
disp('*************************************');
disp(tablaConex);
disp('*************************************');