function [L, U] = Alg7(A)
% LU Factorization without pivoting
% [L, U] = Alg7(A) decomposes matrix A using Crout's algorithm into
% U - upper triangular matrix and L - unit lower triangular matrix
% such that A = LU.

[m, n] = size(A);

% This solution is mathematically correct, however computationaly
% inefficient.
%
% A = Alg1_outer_product_gaussian_elimination(A);
% 
% U = triu(A);
% L = tril(A, -1) + eye(m);

% Instead, we should use the Crout's algorithm

L = zeros(m, n);
U = eye(m, n);

for k = 1:n
    
    for j = k : n
        U(k, j) = A(k, j) - dot(L(k, 1:k-1), U(1:k-1, j));
    end
    
    for i = k:n
        L(i, k) = (A(i, k) - dot(L(i,1:k-1), U(1:k-1, k))) / U(k,k);
    end
    
    
end

end