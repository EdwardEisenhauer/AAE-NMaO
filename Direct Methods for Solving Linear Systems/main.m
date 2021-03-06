clear all;

B = [2, -1, 0, 0; -1, 2, -1, 0;0, -1, 2, -1; 0, 0, -1, 2]

b = [0;0;0;5]

[U, Mk] = outer_product_gaussian_elimination(B)
back_substitution(U, b)