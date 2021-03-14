function [P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A)
% Algorithm 2: Gaussian Elimination with Complete Pivoting.
% [P, Q, L, U] = Alg2_gaussian_elimination_with_complete_pivoting(A)
% computes the complete pivoting factorization PAQ = LU.

[m, n] = size(A);

if m ~= n
    error('Matrix is not square!')
end

% p and q are permutation vectors – respectively rows and columns
p = 1:m;
q = 1:m;

% The following algorithm is based on the Algrotihm 3.4.2 from [2].

for k = 1 : m-1
    i = k:m;
    j = k:m;
    % Find the maximum entry to be the next pivot
    [max_val, rows_of_max_in_col] = max(abs(A(i, j)));
    [~, max_col] = max(max_val);
    max_row = rows_of_max_in_col(max_col);
    % Assign value of mu and lambda in respect to the main matrix A
    [mi, lm] = deal(max_row+k-1, max_col+k-1);
    % Interchange the rows and columns of matrix A...
    A([k mi], 1:m) = deal(A([mi k], 1:m));
    A(1:m, [k lm]) = deal(A(1:m, [lm k]));
    % ...and respective permutation vectors entries.
    p([k, mi]) = p([mi, k]);
    q([k, lm]) = q([lm, k]);
    % Perform Gaussian elimination with the greatest pivot
    if A(k, k) ~= 0
        rows = k+1 : m;
        A(rows, k) = A(rows, k)/A(k, k);
        A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
    end
end

I = eye(m);
U = triu(A);
L = tril(A, -1) + I;
P = I(p, :);
Q = I(:, q);

end