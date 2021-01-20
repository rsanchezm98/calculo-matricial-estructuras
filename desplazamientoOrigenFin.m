function [despBarra] = desplazamientoOrigenFin(origen, fin, desplazamientosGlobales)
    nudoO = origen;
    nudoF = fin;
    if nudoO > 1
        nudoO = nudoO*3 - 2;
    end
    if nudoF > 1
        nudoF = nudoF*3 - 2;
    end
    despOrigen = desplazamientosGlobales(nudoO:nudoO+2);
    despFin = desplazamientosGlobales(nudoF:nudoF+2);
    
    despBarra = [despOrigen;despFin];
end