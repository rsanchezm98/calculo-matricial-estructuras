function ensamblaPlot(desp,despIndependientes,K, tabla)

    figure;
    grid on; hold on;
    title('VALORES DE LA MATRIZ DE RIGIDEZ ENSAMBLADA NECESARIOS');
    axis([1 size(K,1) -size(K,2) -1 ])

    for i = 1:size(K,1)
        scatter(1:size(K,1),-ones(1,size(K,1))*i,150,'blue','filled','s');
    end

    for i = 1:size(despIndependientes,2)
        scatter(desp,-ones(1,size(desp,2))*despIndependientes(i),150,'red','filled','s');
    end
    set(gca,'YTickLabel',[]);

    
 
end