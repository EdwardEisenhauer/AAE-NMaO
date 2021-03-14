function A = Alg5_gauss_jordan_elimination(A)
% Algorithm 5: Gauss-Jordan Elimination
% A = Alg5_gauss_jordan_elimination(A) performs Gauss-Jordan elimination
% on an augmented matrix A.

[m, n] = size(A);

for k = 1 : m
    
    row = A(k, :);
    row = row/row(k);
    A(k, :) = row;
    
    for i = 1 : m
        if i ~= k
            A(i, :) = A(i, :)-(A(i, k))*row;
        end
    end
end

end