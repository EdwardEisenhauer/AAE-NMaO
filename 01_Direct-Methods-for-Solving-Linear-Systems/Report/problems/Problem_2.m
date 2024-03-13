A = [1, 1, 1;
     1, 1, 2;
     1, 2, 2];
b = [1;2;1];
[P, Q, L, U] = Alg2(A);
% PAQ = LU
% Ly = b and Ux = y
y = Alg3(L, P*b);     % Forward substitution
x = Q*Alg4(U, y)      % Backward substitution

x =

     1
    -1
     1