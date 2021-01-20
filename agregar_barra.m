function [K] = agregar_barra(Ke, origen, fin, K)
    if origen > 1
        origen = 3*origen - 2;
    end
    if fin > 1
       fin = 3*fin - 2;
    end   

    KeOO = Ke(1:3,1:3);
    KeOF = Ke(1:3,4:6);
    KeFO = Ke(4:6,1:3);
    KeFF = Ke(4:6,4:6);

    %% primera componente
    for fila = 1:3
        i = fila + origen - 1;
        for columna = 1:3
            j = columna + origen - 1;
            K(i,j) = K(i,j) +  KeOO(fila,columna);
        end
    end

    %% segunda componente
    for fila = 1:3
        i = fila + origen - 1;
        for columna = 1:3
            j = columna + fin - 1;
            K(i,j) = K(i,j) + KeOF(fila,columna);
        end
    end

    %% tercera componente
    for fila = 1:3
        i = fila + fin - 1;
        for columna = 1:3
            j = columna + origen - 1;
            K(i,j) = K(i,j) + KeFO(fila,columna);
        end
    end

    %% cuarta componente
    for fila = 1:3
        i = fila + fin - 1;
        for columna = 1:3
            j = columna + fin - 1;
            K(i,j) = K(i,j) + KeFF(fila,columna);
        end
    end

end