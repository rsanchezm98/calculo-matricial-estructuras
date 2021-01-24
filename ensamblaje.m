%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Ensamblaje de matrices de rigidez del sistema
% Fecha: 23/01/2021
% Orden: 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% generacion de las matrices de rigidez en globales
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

%% ensamblamos las matrices globales en la general

K = zeros(numNudos*3); % creamos la matriz de rigidez ensamblada
for i = 1:tablaConex.ident(end)
    K = agregar_barra(K_{1,i}, tablaConex.origen(i), tablaConex.fin(i), K);
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

K_end = K_simp(:,1:size(despIndependientes,2));
disp('*************************************');
disp("MATRIZ DE RIGIDEZ SIMPLIFICADA SUMADA");
disp(K_end);
disp('*************************************');

% ploteo de los terminos que necesito de la matriz de rigidez
ensamblaPlot(desp,despIndependientes,K,tablaConex); 
