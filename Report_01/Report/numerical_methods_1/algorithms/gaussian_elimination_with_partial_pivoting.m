function B = gaussian_elimination_with_partial_pivoting(A, b)
% GAUSSIAN_ELIMINATION_WITH_PARTIAL_PIVOTING Gaussian elimination with
%   the partial pivoting.
%
%   B = GAUSSIAN_ELIMINATION_WITH_PARTIAL_PIVOTING(A, b) Returns an upper
%     triangular augmented matrix B = [A b], on which the Gaussian
%     elimination with the partial pivoting was performed.
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.

[m, n] = size(A);

if m ~= n
    error('The coefficient matrix A is not square!')
end

B = [A b];

for k = 1:m - 1
    % Find the maximum column entry in the submatrix to be the next pivot
    [~, max_val_row_index] = max(abs(B(k:m,k)));
    % Get the row index with respect to the matrix B
    max_val_row_index = max_val_row_index + k - 1;
    % Interchange the k-th and the maximum entry in the k-th column rows
    B([k, max_val_row_index],:) = B([max_val_row_index, k], :);
    % Perform Gaussian elimination
    rows = k + 1:m;
    B(rows, :) = B(rows, :) - (B(rows, k) / B(k, k)) .* B(k, :);
end

end
