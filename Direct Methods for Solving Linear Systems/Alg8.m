function [L, U, P] = Alg8(A)
% LU Factorization with partial pivoting
% [L, U, P] = Alg8(A) decomposes matrix A using Crout's algorithm into
% U – upper triangular matrix and L – unit lower triangular matrix
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

% TODO: Permutation A*P does not work


% 
% for i = m + 1 : M
%    A(i:end, m+1:end); % Partial matrix (in which we are looking for non-zero pivots)
%    A(i:end, m+1); % Left-most column
%    if ~any(A(i:end, m+1)) % If the left-most column has only zeros check the next one
%        m = m + 1;
%    end
%    A(i:end, m+1:end);
%    if A(i, m+1) == 0
%        non_zero_row = find(A(i:end,m+1), 1);
%        if isempty(non_zero_row)
%            continue
%        end
%        A([i, i+non_zero_row-1], :) = deal(A([i+non_zero_row-1, i], :));
%    end
% end

for k = 1:n
    
    for j = k : n
        U(k, j) = A(k, j) - dot(L(k, 1:k-1), U(1:k-1, j));
    end
    
    for i = k:n
        L(i, k) = (A(i, k) - dot(L(i,1:k-1), U(1:k-1, k))) / U(k,k);
    end
    
    
end

end