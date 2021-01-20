function [Ke] = rigidas(EA, EI, L, alfaGrad)
    alfaRad = deg2rad(alfaGrad); 
    c = cos(alfaRad);
    s = sin(alfaRad);
    Ka = EA/L;
    Ki = 12*EI/(L^3);
    Ke = [Ka*c^2+Ki*s^2    (Ka-Ki)*c*s      -L/2*Ki*s   -Ka*c^2-Ki*s^2   -(Ka-Ki)*c*s     -L/2*Ki*s;
         (Ka-Ki)*c*s     Ka*s^2+Ki*c^2      L/2*Ki*c    -(Ka-Ki)*c*s    -Ka*s^2-Ki*c^2    L/2*Ki*c;
         -L/2*Ki*s        L/2*Ki*c         (L^2)/3*Ki     L/2*Ki*s        -L/2*Ki*c     (L^2)/6*Ki;
         -Ka*c^2-Ki*s^2  -(Ka-Ki)*c*s       L/2*Ki*s    Ka*c^2+Ki*s^2    (Ka-Ki)*c*s      L/2*Ki*s;
         -(Ka-Ki)*c*s   -Ka*s^2-Ki*c^2     -L/2*Ki*c     (Ka-Ki)*c*s     Ka*s^2+Ki*c^2   -L/2*Ki*c;
         -L/2*Ki*s        L/2*Ki*c         (L^2)/6*Ki      L/2*Ki*s        -L/2*Ki*c    (L^2)/3*Ki];
end