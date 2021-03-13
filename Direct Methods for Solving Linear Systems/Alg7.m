function [L, U] = Alg7(A)
% ADDME LU Factorization without pivoting
% [L, U] = Alg7(A) decomposes matrix A into U – upper triangular matrix and
% L – lower unit triangular matrix such, that A = LU.

[m, n] = size(A);

% This solution is mathematically correct, however computationaly
% inefficient.
%
% A = Alg1_outer_product_gaussian_elimination(A);
% 
% U = triu(A);
% L = tril(A, -1) + eye(m);

% Instead, we should use the Crout's algorithm
% It returns an Unit Upper Triangular matrix and a Lower Traingular matrix
% (in oppose to the Gaussian Elimination).
A

L = zeros(m, n)
U = eye(m, n)

for k = 1:n
    for i = k:n
        L(i, k) = A(i, k) - dot(L(i,1:k-1), U(1:k-1, k));
    end
    
    for j = k : n
        U(k, j) = (A(k, j) - dot(L(k, 1:k-1), U(1:k-1, j))) / L(k, k);
    end
end

end