function [NG] = transformVectorFromlocalToGlobal(N, alfa)
    R = localToGlobal(alfa);
    M = zeros(3);
    T = [R M;M R];
    NG = T*N;
    disp(T);
    disp(N);
end