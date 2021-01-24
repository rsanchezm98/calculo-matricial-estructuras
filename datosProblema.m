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

ident =  [1; 2; 3; 4; 5; 6; 7; 8]; % identificador de las barras
origen = [2; 1; 3; 5; 6; 7; 8; 9]; % nudo origen de las barras
fin =    [3; 3; 4; 4; 4; 4; 7; 7]; % nudo fin de las barras
numNudos = 9; % numero de nudos del sistema 

EA = [100; 100; 100; 2000; 2000; 100; 100; 100]; % EA de cada barra (EA/EI en realidad si todo va a ir en funcion de EI)
EI = [20000;20000;20000;20000;20000;20000;20000;20000]; % EI dejarlo a 1 si es todo en referencia de EI
% si dan el valor de EA y EI meter EA y EI respectivamente
L = [2.5; 2.5*sqrt(2); 5; 2.5*sqrt(5);2.5*sqrt(5);5;2.5;2.5*sqrt(2)]; % L de las barras
alfa = [0; -45; 0; atand(2); 180-atand(2);180;180;180+45]; % angulos

% tipos 'artRig', 'rigArt', 'articuladas', 'rigidas'
tipo = {'rigidas'; 'rigidas'; 'rigidas'; 'articuladas';'articuladas';'rigidas';'rigidas';'rigidas'};

% ojo cada nudo es 3*3 luego tenlo en cuenta para poner su indice
% ejemplo quiero el desplazamiento horizontal del nudo 3 luego tengo que poner el 3+3+1
% = 7. Si es el v3 entonces es 3*2 + 2 [3*(n-1)+1-2-3]
desp = [9,11,21]; %% desplazamientos objetivos
despIndependientes = [9,11]; % desplazamientos independientes para la matriz reducida
despNoIndependientes = [21]; % desplazamientos no independientes del sistema
relacionesIndependientesNoIndependientes = [-1]; % se refiere a la posición
% del vector desp con el signo que le corresponde por ejemplo: el 7 es el
% negativo del desplazamiento 4, luego su valor en este vector es - 1

% creación de tabla con los datos
tablaConex = table(ident,origen,fin,tipo,EA,EI,L,alfa);

% mostramos la tabla por pantalla
disp('*************************************');
disp(tablaConex);
disp('*************************************');