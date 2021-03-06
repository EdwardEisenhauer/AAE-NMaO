clear all;

B = [2, -1, 0, 0;
    -1, 2, -1, 0;
    3, -1, 2, -1;
    0, 4, -1, 2];

b = [0;0;0;5];

[U, L] = outer_product_gaussian_elimination(B);
back_substitution(U, b);

[U, L] = gaussian_elimination_with_complete_pivoting(B)
L*U
% A = gauss_jordan_elimination(B)