function A = Alg5_gauss_jordan_elimination(A)
% Algorithm 5: Gauss-Jordan Elimination
% Argument A is an augmented matrix

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