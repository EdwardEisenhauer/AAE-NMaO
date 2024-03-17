function B = gaussian_elimination(A, b)
% GAUSSIAN_ELIMINATION Gaussian elimination.
%
%   B = GAUSSIAN_ELIMINATION(A, b) Returns an upper triangular augmented
%     matrix B = [A b], on which the Gaussian elimination was performed.
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.

[m, n] = size(A);

if m ~= n
    error('The coefficient matrix A is not square!')
end

B = [A b];

for k = 1:n - 1
    rows = k + 1:m;
    B(rows, :) = B(rows, :) - (B(rows, k) / B(k, k)) .* B(k, :);
end

end
