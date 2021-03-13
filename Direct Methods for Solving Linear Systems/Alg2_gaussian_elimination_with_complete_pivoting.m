function [P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A)
% Algorithm 2: Gaussian Elimination with Complete Pivoting.
% [P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A) 

[n, m] = size(A);

if n ~= m
    error('Matrix is not squared!')
end
    
% if det(A) == 0
%     error('Matrix is not nonsingular!')
% end

p = 1:n;
q = 1:n;

for k = 1 : n-1
    i = k:n;
    j = k:n;
    [max_val, rows_of_max_in_col] = max(abs(A(i, j)));
    [~, max_col] = max(max_val);
    max_row = rows_of_max_in_col(max_col);
    % Assign value of mu and lambda in respect to the main A matrix
    [mi, lm] = deal(max_row+k-1, max_col+k-1);
    A([k mi], 1:n) = deal(A([mi k], 1:n));
    A(1:n, [k lm]) = deal(A(1:n, [lm k]));
    p([k, mi]) = p([mi, k]);
    q([k, lm]) = q([lm, k]);
    
    % Perform Gaussian elimination with the greatest pivot
    if A(k, k) ~= 0
        rows = k+1 : n;
        A(rows, k) = A(rows, k)/A(k, k);
        A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
    end
end

I = eye(n);
U = triu(A);
L = tril(A, -1) + I;
P = I(p, :);
Q = I(:, q);