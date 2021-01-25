%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Obtención de desplazamiento y esfuerzos en locales de las barras
% Fecha: 23/01/2021
% Orden: 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Obtención de desplazamientos
F = [0;-7.0125;3.50625;-25.5]; % introduce el vector de fuerzas obtenido

x = linsolve(K_end,F);
disp('*************************************');
disp('DESPLAZAMIENTOS DE LOS INDEPENDIENTES');
for i = 1:size(x,1)
    disp(['Desplazamiento # ' num2str(despIndependientes(i)) ' = ' num2str(x(i))]);
end
disp('*************************************');

disp('DESPLAZAMIENTOS DE LOS NO INDEPENDIENTES');
x_Dep = zeros(size(despNoIndependientes,1));
for i = 1:size(despIndependientes,2)
        id = find(relacionesIndependientesNoIndependientes == i);
        if (size(id)>0)
            for j = id
                x_Dep(j) = x(i);
            end
        end
        id = find(relacionesIndependientesNoIndependientes == -1*i);
        if (size(id)>0)
            for j = id
                x_Dep(j) = -1*x(i);
            end
        end
end
for i = 1:size(x_Dep,2)
    disp(['Desplazamiento # ' num2str(despNoIndependientes(i)) ' = ' num2str(x_Dep(i))]);
end
disp('*************************************');



%% el vector global de desplazamientos es:
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
   disp(['VECTOR DE ESFUERZOS LOCALES DE LA BARRA: ' num2str(i)]);
   disp(esfuerzos{1,i});
   disp('*************************************');
end
disp('HAY QUE SUMARLE LAS FUERZAS EXTERNAS');
% TENGO QUE SUMARLE LAS FUERZAS EXTERNAS

%% Añadir superposición
% DESCOMENTAR AQUELLO QUE SE VAYA A SUPERPONER EN FUNCIÓN DE LOS DATOS
% modificamos el vector de esfuerzos esfuerzos{1,i} sumandole lo
% correspondiente a las fuerzas aplicadas a lo largo de la barra

% esfuerzos{1,1} = esfuerzos{1,1} + [0; 14.531; 19.6875; 0; 10.64688; 0];
 esfuerzos{1,2} = esfuerzos{1,2} + [0;12.75; 3.50625;0; 12.75; -3.50625];
% esfuerzos{1,3} = esfuerzos{1,3} + [0; -12.5; -15.625; 0; -12.5; 15.625];
% esfuerzos{1,4} = esfuerzos{1,4} + [0; 55e3; 42426.4; 0; 25e3; 0];
 esfuerzos{1,5} = esfuerzos{1,5} + [0 ; -12.75; -3.50625;0; -12.75; 3.50625];
% esfuerzos{1,6} = esfuerzos{1,6} + [0; 12.5; 15.625; 0; 12.5; -15.625];
% esfuerzos{1,7} = esfuerzos{1,7} + [0; 5/2; 2; 0; 15/8; 0];
 esfuerzos{1,8} = esfuerzos{1,8} + [0; -12.75; -3.50625;0; -12.75; 3.50625];
 esfuerzos{1,11} = esfuerzos{1,11} + [0;12.75;3.50625;0; 12.75; -3.50625];

% modificamos el vector de esfuerzos añadiendo las fuerzas aplicadas debido
% a la temperatura. 
%  esfuerzos{1,1} = esfuerzos{1,1} + Tempo{1,1};
%  esfuerzos{1,2} = esfuerzos{1,2} + Tempo{1,2};
%  esfuerzos{1,3} = esfuerzos{1,3} + Tempo{1,3};
%  esfuerzos{1,4} = esfuerzos{1,4} + Tempo{1,4};
% esfuerzos{1,5} = esfuerzos{1,5} + Tempo{1,5};


disp('SUMADAS LAS FUERZAS EXTERNAS');
for i = 1:tablaConex.ident(end)
   disp('*************************************');
   disp(['VECTOR DE ESFUERZOS LOCALES DE LA BARRA: ' num2str(i)]);
   disp(esfuerzos{1,i});
   disp('*************************************');
end


