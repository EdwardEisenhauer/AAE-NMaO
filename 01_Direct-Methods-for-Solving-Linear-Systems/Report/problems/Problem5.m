A = [2, 1, 2;
     1, 2, 3;
     4, 1, 2];
[P, Q, L, U] = Alg2(A);
I = P*eye(3);
% Ly = b and Ux = y
y = Alg3(L, I);     % Forward substitution
x = Q*Alg4(U, y);   % Backward substitution
inv(A) - x

ans =

   1.0e-15 *

   -0.2220    0.0555    0.1110
    0.8882   -0.4441   -0.6661
         0    0.1110         0