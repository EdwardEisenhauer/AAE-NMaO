function A = Alg6_RREF(A)
% Algorithm 6: Reduced Row Echelon Form (RREF)
% A = Alg6_RREF(A) returns RREF of matrix A. 

[M, N] = size(A);

n = 0;

for m = 1 : M
    n = n + 1;
    if n > N
        break
    end
    % We want the left-most coefficient to be 1 (pivot)
    row = A(m, :);
    if row(m) == 0
        n = n + 1;
    end
    row = row/row(n);
    A(m, :) = row;
    
    for i = 1 : M
        if i ~= m
            A(i, :) = A(i, :)-(A(i, n))*row;
        end
    end
    
    for i = m + 1 : M
       A(i:end, m+1:end); % Partial matrix (in which we are looking for non-zero pivots)
       A(i:end, m+1); % Left-most column
       if ~any(A(i:end, m+1)) % If the left-most column has only zeros check the next one
           m = m + 1;
       end
       A(i:end, m+1:end);
       if A(i, m+1) == 0
           non_zero_row = find(A(i:end,m+1), 1);
           if isempty(non_zero_row)
               continue
           end
           A([i, i+non_zero_row-1], :) = deal(A([i+non_zero_row-1, i], :));
       end
    end
end

end

