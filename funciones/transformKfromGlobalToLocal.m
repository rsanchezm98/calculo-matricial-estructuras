function [Ke] = transformKfromGlobalToLocal(Ki, alfa)
    R = globalToLocal(alfa);
    M = zeros(3);
    T = [R M;M R];
    Ke = T*Ki*T';
end