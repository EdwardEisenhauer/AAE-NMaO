function [L, U, P] = Alg8(A)
% LU Factorization with partial pivoting
% [L, U, P] = Alg8(A) decomposes matrix A using Crout's algorithm into
% U - upper triangular matrix and L - unit lower triangular matrix
% using partial pivoting, interchanging A's rows, such that AP = LU.

[m, n] = size(A);

L = zeros(m, n);
U = eye(m, n);
P = eye(m, n);

for k = 1:m
    if A(k, k) == 0
        non_zero_col = find(A(k, :), 1);
        A(:, [k non_zero_col]) = deal(A(:, [non_zero_col k]));
        P(:, [k non_zero_col]) = deal(P(:, [non_zero_col k]));
    end
end

for k = 1:n
    
    for j = k : n
        U(k, j) = A(k, j) - dot(L(k, 1:k-1), U(1:k-1, j));
    end
    
    for i = k:n
        L(i, k) = (A(i, k) - dot(L(i,1:k-1), U(1:k-1, k))) / U(k,k);
    end
    
    
end

end