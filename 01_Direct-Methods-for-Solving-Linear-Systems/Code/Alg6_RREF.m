function A = Alg6_RREF(A)
% Algorithm 6: Reduced Row Echelon Form (RREF)
% A = Alg6_RREF(A) returns RREF of matrix A. 

[m, n] = size(A);

j = 0;

for k = 1 : m
    j = j + 1;
    if j > n
        break
    end
    % We want the left-most coefficient to be 1 (pivot)
    row = A(k, :);
    if row(k) == 0
        j = j + 1;
    end
    row = row/row(j);
    A(k, :) = row;
    
    for i = 1 : m
        if i ~= k
            A(i, :) = A(i, :)-(A(i, j))*row;
        end
    end
    
    for i = k + 1 : m
       A(i:end, k+1:end); % Partial matrix (in which we are looking for non-zero pivots)
       A(i:end, k+1); % Left-most column
       if ~any(A(i:end, k+1)) % If the left-most column has only zeros check the next one
           k = k + 1;
       end
       A(i:end, k+1:end);
       if A(i, k+1) == 0
           non_zero_row = find(A(i:end,k+1), 1);
           if isempty(non_zero_row)
               continue
           end
           A([i, i+non_zero_row-1], :) = deal(A([i+non_zero_row-1, i], :));
       end
    end
end

end

