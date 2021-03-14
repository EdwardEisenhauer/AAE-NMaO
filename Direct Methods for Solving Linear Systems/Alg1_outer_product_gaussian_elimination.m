function A = Alg1_outer_product_gaussian_elimination(A)
% Algorithm 1: Outer Product Gaussian Elimination
% Performs a gaussian eliminaion on a square matrix A.

[m, n] = size(A);

if m ~= n
    error('Matrix is not square!')
end

for k = 1:n-1
    if det(A(1:k, 1:k)) < eps
        error('Matrix is not nonsingular!')
    end
end

% The following algorithm is based on the Algrotihm 3.2.1 from [2].

for k = 1 : m-1
    rows = k + 1 : m;
    A(rows, k) = A(rows, k)/A(k, k);
    A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
end
 
end