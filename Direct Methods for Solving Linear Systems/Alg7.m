function [L, U] = Alg7(A)
% ADDME LU Factorization without pivoting
% [L, U] = Alg7(A) decomposes matrix A into U – upper triangular matrix and
% L – lower unit triangular matrix such, that A = LU.

[m, n] = size(A);

A = Alg1_outer_product_gaussian_elimination(A);

U = triu(A);
L = tril(A, -1) + eye(m);

end