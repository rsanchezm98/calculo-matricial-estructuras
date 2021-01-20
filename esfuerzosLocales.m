    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% usar despues de ensamblaje
F = [0;2]; % introduce el vector de fuerzas obtenido
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = linsolve(K_end,F);
disp('*************************************');
disp('DESPLAZAMIENTOS DE LOS INDEPENDIENTES');
for i = 1:size(x,1)
    disp(['Desplazamiento # ' num2str(despIndependientes(i)) ' = ' num2str(x(i))]);
end
disp('*************************************');

disp('DESPLAZAMIENTOS DE LOS NO INDEPENDIENTES');
x_Dep = [];
for i = 1:size(despIndependientes,2)
        id = find(relacionesIndependientesNoIndependientes == i);
        if (size(id)>0)
            x_Dep(end+1) = x(i);
        end
        id = find(relacionesIndependientesNoIndependientes == -1*i);
        if (size(id)>0)
            x_Dep(end+1) = -1*x(i);
        end
end
for i = 1:size(x_Dep,2)
    disp(['Desplazamiento # ' num2str(despNoIndependientes(i)) ' = ' num2str(x_Dep(i))]);
end
disp('*************************************');

% el vector global de desplazamientos es:
desplazamientos = zeros(numNudos*3,1);
for i = desp
    id = find(despIndependientes == i);
    if (size(id)>0) 
        desplazamientos(i) = x(id);
    else
        id = find(despNoIndependientes == i);
        if (size(id)>0)
            desplazamientos(i) = x_Dep(id);
        end
    end
end

% hay que transformar a locales los desplazamientos y multiplicar por las
% matrices en locales

% transformo las columnas a locales

for i = 1:tablaConex.ident(end)
    desplazamientosBarra = desplazamientoOrigenFin(tablaConex.origen(i), ...
        tablaConex.fin(i), desplazamientos);
    local_O = globalToLocal(tablaConex.alfa(i))*desplazamientosBarra(1:3);
    local_F = globalToLocal(tablaConex.alfa(i))*desplazamientosBarra(4:6);
    despLocal{i} = [local_O;local_F];
end
% tengo un cell array de los desplazaminetos de las barras (ORIGEN - FIN)

% transformo las matrices de rigidez globales en locales
for i = 1:tablaConex.ident(end)
    K_local{i} = transformKfromGlobalToLocal(K_{1,i}, tablaConex.alfa(i));
end

% multiplico las matrices locales por los desplazamientos y saco los
% ESFUERZOS en locales. 

for i = 1:tablaConex.ident(end)
   esfuerzos{i} = K_local{1,i}*despLocal{1,i};
   disp('*************************************');
   disp(['VECTOR DE ESFUERZOS DE LA BARRA: ' num2str(i)]);
   disp(esfuerzos{1,i});
   disp('*************************************');
end
disp('HAY QUE SUMARLE LAS FUERZAS EXTERNAS');
% TENGO QUE SUMARLE LAS FUERZAS EXTERNAS

% modificamos el vector de esfuerzos esfuerzos{1,i} sumandole lo
% correspondiente al vector de esfuerzos SUPERPOSICION

esfuerzos{1,2} = esfuerzos{1,2} + [0; 1.875; 0; 0; 3.125; -3.125];
esfuerzos{1,3} = esfuerzos{1,3} + [0; -2.5; -1; 0; -1.5; 0];
esfuerzos{1,4} = esfuerzos{1,4} + [0; -1.875; 0; 0; 3.125; -3.125];
esfuerzos{1,5} = esfuerzos{1,5} + [0; 2.5; -1; 0; -1.5; 0];


disp('SUMADAS LAS FUERZAS EXTERNAS');
for i = 1:tablaConex.ident(end)
   disp('*************************************');
   disp(['VECTOR DE ESFUERZOS DE LA BARRA: ' num2str(i)]);
   disp(esfuerzos{1,i});
   disp('*************************************');
end


