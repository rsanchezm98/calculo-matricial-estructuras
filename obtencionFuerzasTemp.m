%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Obtención de esfuerzos internos por temperatura y fuerzas
% aplicadas sobre las barras
% Fecha: 23/01/2021
% Orden: 2-3
% Descripción: Usar cuando se trate de un problema con diferencias
% térmicas, es necesario lanzarlo antes del esfuerzosLocales puesto que se
% necesitan las fuerzas sobre los nudos para el vector F y así obtener los
% desplazamientos. Se necesita también para superponer los esfuerzos
% derivados internos de la diferencia de temperaturas. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% CÁLCULOS DE TEMPERATURAS

temp1 = [50,0,0,20,50]; % TEMPERATURA POR ENCIMA EN LOCALES
temp2 = [0,20,50,0,20]; % TEMPERATURA POR DEBAJO EN LOCALES
coef = [12e-6,12e-6,12e-6,12e-6,12e-6]; % coeficiente
canto = [0.12,0.12,0.12,0.12,0.12]; % CANTO
% 'biempotrada', 'apoyadaEmpotrada', 'empotradaApoyada', 'biapoyada',
% 'isostatica', 'nada'
tipoT = {'biempotrada'; 'biempotrada'; 'biempotrada'; 'biempotrada';'biempotrada'};

deltaT = [];
diff = [];
for i = 1:size(temp1,2)
    deltaT(end+1) = (temp2(i) + temp1(i))/2;
    diff(end+1) = (temp1(i) - temp2(i));
end
% si nos dan directamente estos valores
%deltaT = [0,20,20,20];
%diff = [0,0,0,0];


% generacion de los vectores de superposicion de temperaturas esto se le
% añade en el apartado de esfuerzos locales
for i = 1:tablaConex.ident(end)
    if strcmp(tipoT(i),'biempotrada')
            Tempo{i} = biempotrada(tablaConex.EA(i), tablaConex.EI(i), coef(i),...
                deltaT(i),diff(i),canto(i));
    end
    
    if strcmp(tipoT(i),'apoyadaEmpotrada')
             Tempo{i} = apoyadaEmpotrada(tablaConex.EA(i), tablaConex.EI(i), coef(i),...
                deltaT(i),diff(i),canto(i), tablaConex.L(i));
    end
    
    if strcmp(tipoT(i),'empotradaApoyada')
             Tempo{i} = empotradaApoyada(tablaConex.EA(i), tablaConex.EI(i), coef(i),...
                deltaT(i),diff(i), canto(i), tablaConex.L(i));  
    end
    if strcmp(tipoT(i),'biapoyada')
             Tempo{i} = biapoyada(tablaConex.EA(i),coef(i),...
                deltaT(i));  
    end
    
    if strcmp(tipoT(i),'isostatica')
         Tempo{i} = [0;0;0;0;0;0];  
    end
    
    if strcmp(tipoT(i),'nada')
         Tempo{i} = [0;0;0;0;0;0];  
    end
    
     disp(['Barra: ' num2str(i) ' vector de esfuerzos por temp en LOCALES']);
     disp(Tempo{1,i});
end

% transformamos a globales para obtener las fuerzas aplicadas en el inicio
% y fin de cada barra

for i = 1:tablaConex.ident(end)
    
    TempoGlobal{i} = -1*transformVectorFromlocalToGlobal(Tempo{1,i},tablaConex.alfa(i)); 
    % cambio el signo porque lo que quiero es fuerza aplicada sobre las
    % barras. Como se puede ver no se ha aplicado a los esfuerzos en
    % locales puesto que son ESFUERZOS internos de las barras y no fuerzas
    % aplicadas
    
    disp(['Barra: ' num2str(i) ' vector de esfuerzos por temp en GLOBALES']);
    disp(TempoGlobal{1,i});
    
end

for i = 1:numNudos
    TempNudo{i} = zeros(3,1);
end
for i = 1:numNudos
    
    %sumo origenes
    id = find(tablaConex.origen == i);
    for j = id'
        TempNudo{1,i} =  TempNudo{1,i} + TempoGlobal{1,j}(1:3); 
    end
    
    %sumo fines
    id = find(tablaConex.fin == i);
    for j = id'
        TempNudo{1,i} =  TempNudo{1,i} + TempoGlobal{1,j}(4:6); 
    end    
    
    % obtenemos las fuerzas aplicadas sobre cada nudo sumando todas las
    % barras. 
end
TempNudos = [];
for i = 1:numNudos
   disp('*************************************');
   disp(['NUDO # : ' num2str(i)]);
   disp(TempNudo{1,i});
   disp('*************************************');  
   TempNudos(end+1:end+3) = TempNudo{1,i};
end

% este es el vector de fuerzas térmicas que hay que añadir para calcular
% los desplazamientos en el esfuerzosLocales.m
F = [];
for i = despIndependientes
    F(end+1) = TempNudos(i);
end

disp("VECTOR DE FUERZAS TÉRMICAS");
disp(F);