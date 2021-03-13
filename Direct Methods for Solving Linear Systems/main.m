clear all;
clc;

A = [2, -1, 0, 0;
    -1, 2, -1, 0;
    0, -1, 2, -1;
    0, 0, -1, 2];

b = [0;0;0;5];

B = Alg1_outer_product_gaussian_elimination(A);
U = triu(B);
x = Alg4_back_substitution(U, b);

%% Problem 1
clear all;
A = [2, -1, 0, 0;
    -1, 2, -1, 0;
    0, -1, 2, -1;
    0, 0, -1, 2];

b = [0;0;0;5];

B = gauss_jordan_elimination([A b])

[P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A);

b = P*b;
% Ly = b and Ux = y
y = forward_substitution(L, b);

x = Q*back_substitution(U, y);

% L*U

%% Problem 2
A = [1, 1, 1;
     1, 1, 2;
     1, 2, 2];

b = [1;2;1];

[P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A);

b = P*b;
% Ly = b and Ux = y
y = Alg3_forward_substitution(L, b);

x = Q*Alg4_back_substitution(U, y)

% L*U


%% Problem 4

A = [0.835, 0.667;
     0.333, 0.266];
b = [0.168; 0.067];
bp = [0.168; 0.066];

kappa = cond(A)

B = Alg5_gauss_jordan_elimination([A b])
Bp = Alg5_gauss_jordan_elimination([A bp])

%% Problem 5
% AX = I3
A = [2, 1, 2;
     1, 2, 3;
     4, 1, 2];
 
[P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A);

I = P*eye(3);
% Ly = b and Ux = y
y = forward_substitution(L, I);

X = Q*back_substitution(U, y)
inv(A)

%% Problem 6

%% Problem 10

% A = [1 2 2 3 1;
%      2 4 4 6 2;
%      3 6 6 9 6;
%      1 2 4 5 3]

A = [0.835, 0.667;
     0.333, 0.266];
b = [0.168; 0.067];
 
Alg6_RREF([A b])


