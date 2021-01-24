%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Rodrigo Sánchez Molina
% Script: Obtención de las reacciones sobre los nudos del sistema. 
% Fecha: 23/01/2021
% Orden: 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('*************************************');
disp('REACCIONES GLOBALES EN LOS APOYOS');
for i = 1:tablaConex.ident(end)
   esfuerzosGlobales{i} = transformVectorFromlocalToGlobal(esfuerzos{1,i},...
       tablaConex.alfa(i));
%     disp('*************************************');
%     disp(['ESFUERZO en GLOBAL BARRA # ' num2str(i) ' NUDO ORIGEN # : ' num2str(tablaConex.origen(i))]);
%     disp(esfuerzosGlobales{1,i}(1:3));
%     disp(['ESFUERZO en GLOBAL BARRA # ' num2str(i) ' NUDO FIN # : ' num2str(tablaConex.fin(i))]);
%     disp(esfuerzosGlobales{1,i}(4:6));
%     disp('*************************************');
end


for i = 1:numNudos
    reaccionNudos{i} = zeros(3,1);
end

for i = 1:numNudos
    
    %sumo origenes
    id = find(tablaConex.origen == i);
    for j = id'
        reaccionNudos{1,i} =  reaccionNudos{1,i} + esfuerzosGlobales{1,j}(1:3); 
    end
    
    %sumo fines
    id = find(tablaConex.fin == i);
    for j = id'
        reaccionNudos{1,i} =  reaccionNudos{1,i} + esfuerzosGlobales{1,j}(4:6); 
    end    

end

% display de los nudos
for i = 1:numNudos
   disp('*************************************');
   disp(['NUDO # : ' num2str(i)]);
   disp(reaccionNudos{1,i});
   disp('*************************************');  
end