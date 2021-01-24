%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Datos del sistema y ensamblaje en forma simbólica
% Fecha: 23/01/2021
% Orden: 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
format short

addpath('funciones/'); % añadimos las funciones al path de trabajo

% DEFINICIÓN DE LAS VARIABLES SIMBÓLICAS
syms H alfa_ EI_;

% introduccion de las variables del problema
ident =  [1; 2; 3; 4; 5; 6; 7; 8; 9]; % identificador de las barras
origen = [1; 2; 1; 4; 2; 1; 6; 4; 6]; % nudo origen de las barras
fin =    [2; 3; 4; 2; 5; 6; 7; 6; 8]; % nudo fin de las barras
numNudos = 8; % numero de nudos del sistema
EA = [alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_; alfa_*EI_]; % EA de cada barra (EA/EI en realidad si todo va a ir en funcion de EI)
EI = [EI_;EI_;EI_;EI_;EI_;EI_;EI_;EI_;EI_]; % EI dejarlo a 1 si es todo en referencia de EI
% si dan el valor de EA y EI meter EA y EI respectivamente
L = [H; H; H; H*sqrt(2);H*sqrt(2);H;H;H*sqrt(2);H*sqrt(2)]; % L de las barras
alfa = [0; 0; 90; -45;-45;180;180;180+45;180+45]; % angulos
% tipos 'artRig', 'rigArt', 'articuladas', 'rigidas'
tipo = {'rigArt'; 'artRig'; 'rigArt'; 'articuladas';'artRig'; 'rigArt'; 'artRig'; 'articuladas'; 'artRig'};
tablaConex = table(ident,origen,fin,tipo,EA,EI,L,alfa);
% ojo cada nudo es 3*3 luego tenlo en cuenta para poner su indice
% ejemplo quiero el desplazamiento horizontal del nudo 3 luego tengo que poner el 3+3+1
% = 7
% si es el v3 entonces es 3*2 + 2 [3*(n-1)+1-2-3]
desp = [2,4,5,11,16,17]; %% desplazamientos objetivos
despIndependientes = [2,4,5,11]; % desplazamientos independientes para la matriz reducida
despNoIndependientes = [16,17];
relacionesIndependientesNoIndependientes = [-2,3]; % se refiere a la posición
% del vector desp con el signo que le corresponde por ejemplo: el 7 es el
% negativo del desplazamiento 4, luego su valor en este vector es - 1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('*************************************');
disp(tablaConex);
disp('*************************************');
% generacion de las matrices de rigidez
for i = 1:tablaConex.ident(end)
    if strcmp(tablaConex.tipo(i),'artRig')
            K_{i} = artRig(tablaConex.EA(i), tablaConex.EI(i), tablaConex.L(i),...
                tablaConex.alfa(i));
    end
    
    if strcmp(tablaConex.tipo(i),'rigidas')
             K_{i} = rigidas(tablaConex.EA(i), tablaConex.EI(i), tablaConex.L(i),...
                tablaConex.alfa(i));
    end
    
    if strcmp(tablaConex.tipo(i),'articuladas')
             K_{i} = articuladas(tablaConex.EA(i),tablaConex.L(i),...
                tablaConex.alfa(i));  
    end
    if strcmp(tablaConex.tipo(i),'rigArt')
            K_{i} = rigArt(tablaConex.EA(i), tablaConex.EI(i), tablaConex.L(i),...
                tablaConex.alfa(i));
    end
end

for i = 1:size(K_, 2)
    disp(['MATRIZ DE RIGIDEZ DE LA BARRA: ' num2str(i)]);
    disp(K_{1,i})
end
% ensamblamos las matrices
K = zeros(numNudos*3); % creamos la matriz de rigidez ensamblada
K = sym(K);
for i = 1:tablaConex.ident(end)
    K = agregar_barra(K_{1,i}, tablaConex.origen(i), tablaConex.fin(i), K);
end
disp('*************************************');
disp("MATRIZ DE RIGIDEZ GLOBAL ENSAMBLADA");
disp(K);
disp('*************************************');

%% matriz simplificada

K_simp = sym([]);
for i = despIndependientes
    aux_ = sym([]);
        for j = desp
            aux_(end+1) = K(i,j);
        end
    K_simp(end+1,:) = aux_;
end
% el orden es el indicado en despIndependientes que deberia estar ordenado
disp('*************************************');
disp("MATRIZ DE RIGIDEZ SIMPLIFICADA SIN SUMAR");
disp(K_simp);
disp('*************************************');

for i = 1:size(despIndependientes,2)
    disp(i)
        id = find(relacionesIndependientesNoIndependientes == i);
        if (size(id)>0)
            disp(['sumo columna: ', num2str(i), ' con columna: ', num2str(id+size(despIndependientes,2))]);
            K_simp(:,i) = K_simp(:,i) + K_simp(:,id+size(despIndependientes,2));
        end
        id = find(relacionesIndependientesNoIndependientes == -1*i);
        if (size(id)>0)
            disp(['resto columna: ', num2str(i), ' con columna: ', num2str(id+size(despIndependientes,2))]);
            K_simp(:,i) = K_simp(:,i) - K_simp(:,id+size(despIndependientes,2));
        end
    
end
K_end =K_simp(:,1:size(despIndependientes,2));
disp('*************************************');
disp("MATRIZ DE RIGIDEZ SIMPLIFICADA SUMADA");
disp(vpa(K_end));
disp('*************************************');



