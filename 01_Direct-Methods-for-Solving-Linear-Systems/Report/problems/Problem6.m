A = [1 2 3 4;
    -1 1 2 1;
     0 2 1 3;
     0 0 1 1];
b = [1; 1; 1; 1];
% PA = LU
[L, U, P] = Alg8(A);
det(A) - prod(diag(P.'*U))
% Ly = b and Ux = y
y = Alg3(L, P*b);   % Forward substitution
x = Alg4(U, y);   % Backward substitution
x - A\b

ans =

     0


ans =

   1.0e-15 *

    0.4441
         0
         0
         0