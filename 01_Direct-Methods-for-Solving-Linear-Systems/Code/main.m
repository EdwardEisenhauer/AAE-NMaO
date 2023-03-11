%% Problem 1
clear all;
clc;
A = [2, -1, 0, 0;
    -1, 2, -1, 0;
    0, -1, 2, -1;
    0, 0, -1, 2];
b = [0;0;0;5];
B = Alg5([A b])

%% Problem 2
clear all;
clc;
A = [1, 1, 1;
     1, 1, 2;
     1, 2, 2];
b = [1;2;1];

[P, Q, L, U] = Alg2(A);

b = P*b;
% Ly = b and Ux = y
y = Alg3(L, b);     % Forward substitution
x = Q*Alg4(U, y)	% Backward substitution

%% Problem 4

A = [0.835, 0.667;
     0.333, 0.266];
b = [0.168; 0.067];
bp = [0.168; 0.066];

kappa = cond(A)

B = Alg5([A b])
Bp = Alg5([A bp])

%% Problem 5
clear all;
clc;
A = [2, 1, 2;
     1, 2, 3;
     4, 1, 2];
 
[P, Q, L, U] = Alg2(A)

I = P*eye(3);
% Ly = b and Ux = y
y = Alg3(L, I);     % Forward substitution
x = Q*Alg4(U, y)    % Backward substitution
inv(A) - x

%% Problem 6
clc;

A = [1 2 3 4;
    -1 1 2 1;
     0 2 1 3;
     0 0 1 1];

[L, U, P] = Alg8(A)
det(A) - prod(diag(U))

%% Problem 10

% A = [1 2 2 3 1;
%      2 4 4 6 2;
%      3 6 6 9 6;
%      1 2 4 5 3]

A = [0.835, 0.667;
     0.333, 0.266];
b = [0.168; 0.067];
 
Alg6_RREF([A b])


