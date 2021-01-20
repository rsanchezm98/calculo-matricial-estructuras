function [R] = globalToLocal(alfaGrad)
    alfaRad = deg2rad(alfaGrad); 
    c = cos(alfaRad);
    s = sin(alfaRad); 
    R = [c s 0 ;...
        -s c 0;
        0 0 1];
end
