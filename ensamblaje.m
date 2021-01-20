%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Resolucion de problemas de ESTRUCTURAS
%format long
% introduccion de las variables del problema
ident = [1; 2; 3; 4; 5]; % identificador de las barras
origen = [1; 1; 3; 1; 3]; % nudo origen de las barras
fin = [3; 2; 4; 5; 6]; % nudo fin de las barras
numNudos = 6; % numero de nudos del sistema
EA = [5; 5; 5; 5; 5]; % EA de cada barra (EA/EI en realidad si todo va a ir en funcion de EI)
EI = [1; 1; 1; 1; 1]; % EI dejarlo a 1 si es todo en referencia de EI
% si dan el valor de EA y EI meter EA y EI respectivamente
L = [4; 5; 2; 5; 2]; % L de las barras
alfa = [90; 0; 0; 180; 180]; % angulos
% tipos 'artRig', 'rigArt', 'articuladas', 'rigidas'
tipo = {'artRig'; 'artRig'; 'rigArt'; 'artRig'; 'rigArt'};
tablaConex = table(ident,origen,fin,tipo,EA,EI,L,alfa);
% ojo cada nudo es 3*3 luego tenlo en cuenta para poner su indice
% ejemplo quiero el desplazamiento horizontal del nudo 3 luego tengo que poner el 3+3+1
% = 7
desp = [7,9]; %% desplazamientos objetivos
despIndependientes = [7,9]; % desplazamientos independientes para la matriz reducida
despNoIndependientes = [];
relacionesIndependientesNoIndependientes = []; % se refiere a la posición
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
for i = 1:tablaConex.ident(end)
    K = agregar_barra(cell2mat(K_(i)), tablaConex.origen(i), tablaConex.fin(i), K);
end
disp('*************************************');
disp("MATRIZ DE RIGIDEZ GLOBAL ENSAMBLADA");
disp(K);
disp('*************************************');

%% matriz simplificada

K_simp = [];
for i = despIndependientes
    aux_ = [];
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
disp(K_end);
disp('*************************************');



