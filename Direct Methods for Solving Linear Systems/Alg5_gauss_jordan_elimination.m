function A = Alg5_gauss_jordan_elimination(A)
% Algorithm 5: Gauss-Jordan Elimination
% Argument A is an augmented matrix

% M – rows, N – columns

[M, N] = size(A);

for m = 1 : M
    
    row = A(m, :);
    row = row/row(m);
    A(m, :) = row;
    
    for n = 1 : M
        if n ~= m
            A(n, :) = A(n, :)-(A(n, m))*row;
        end
    end
end
end