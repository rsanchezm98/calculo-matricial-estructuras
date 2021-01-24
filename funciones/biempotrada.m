function [N] = biempotrada (EA, EI, coef, deltaM,circM, canto)
    N = zeros(6,1);
    N(1) = EA*coef*deltaM;
    N(3) = -1*EI*coef*circM/canto;
    N(4) = -1*N(1);
    N(6) = EI*coef*circM/canto;
end