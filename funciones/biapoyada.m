function [N] = biapoyada (EA, coef, deltaM)
    N = zeros(6,1);
    N(1) = EA*coef*deltaM;
    N(4) = -1*N(1);
end