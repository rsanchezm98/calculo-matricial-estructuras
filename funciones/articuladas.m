function [Ke] = articuladas(EA, L, alfaGrad)
    alfaRad = deg2rad(alfaGrad); 
    c = cos(alfaRad);
    s = sin(alfaRad);
    Ke = [ c^2   c*s   0   -c^2   -c*s   0;
          c*s   s^2   0   -c*s   -s^2   0;
          0      0    0    0       0    0;
         -c^2  -c*s   0   c^2    c*s    0;
         -c*s  -s^2   0   c*s    s^2    0;
           0     0    0    0      0     0];
    Ke = Ke.*EA/L;
end
