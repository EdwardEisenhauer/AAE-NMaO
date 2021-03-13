% Algorithm 5: Gauss-Jordan Elimination
% Argument A is an augmented matrix
function A = gauss_jordan_elimination(A)

% M – rows, N – columns

[M, N] = size(A);
% 
% if M + 1 ~= N
%     error('Matrix is not squared!')
% end
%     
% if det(A) == 0
%     error('Matrix is not nonsingular!') 
% end

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