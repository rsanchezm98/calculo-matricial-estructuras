function [N] = empotradaApoyada (EA, EI, coef, deltaM, circM, canto, L)

    N = zeros(6,1);
    N(1) = EA*coef*deltaM;
    N(2) = -1*(3/2*EI*coef*circM/canto)/L;
    N(3) = -1*3/2*EI*coef*circM/canto;
    N(4) = -1*N(1);
    N(5) = (3/2*EI*coef*circM/canto)/L;
end