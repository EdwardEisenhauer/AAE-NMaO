% Algorithm 5: Gauss-Jordan Elimination
% Input A is an augmented matrix
function A = gauss_jordan_elimination(A)

[n, m] = size(A);

if n + 1 ~= m
    error('Matrix is not squared!')
end
    
% if det(A) == 0
%     error('Matrix is not nonsingular!') 
% end

for k = 1 : m-1
    
    row = A(k, :);
    row = row/row(k);
    A(k, :) = row;
    for l = 1 : m-1
        if l ~= k
            A(l, :) = A(l, :)-(A(l, k))*row;
        end
    end
end