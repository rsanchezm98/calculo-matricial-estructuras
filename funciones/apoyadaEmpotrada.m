function [N] = apoyadaEmpotrada (EA, EI, coef, deltaM, circM, canto, L)

    N = zeros(6,1);
    N(1) = EA*coef*deltaM;
    N(2) = (3/2*EI*coef*circM/canto)/L;
    N(4) = -1*N(1);
    N(5) = -1*(3/2*EI*coef*circM/canto)/L;
    N(6) = 1*3/2*EI*coef*circM/canto;
end