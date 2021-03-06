function A = gaussian_elimination_with_complete_pivoting(A)

% det(A(mi, lm))

[n, m] = size(A);
if n ~= m
    error('Matrix is not squared!')
end
    
if det(A) == 0
    error('Matrix is not nonsingular!')
end

for k = 1 : n-1
    i = k:n;
    j = k:n;
    A(i, j);
    maximum = max(abs(A(i, j)), [], 'all');
    max_idx = find(abs(A==maximum));
    [mi, lm] = ind2sub(size(A), max_idx(1));
    A([k mi], 1:n) = deal(A([mi k], 1:n));
    A(1:n, [k lm]) = deal(A(1:n, [lm k]));
    p(k) = mi;
    q(k) = lm;
    % Perform Gaussian elimination with the greatest pivot
    if A(k, k) ~= 0
        rows = k+1 : n;
        A(rows, k) = A(rows, k)/A(k, k);
        A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
    end
end
