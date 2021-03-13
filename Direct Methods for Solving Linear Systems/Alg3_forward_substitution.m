function b = Alg3_forward_substitution(L, b)
% Algorithm 3: Forward Substitution (Golub, Loan, Alg. 3.1.1)

    [m, n] = size(L);
    if m ~= n
        error('Matrix is not squared!')
    end

    if length(b) ~= m
        error('Vector b has wrong length!')
    end

    b(1, :) = b(1, :)/L(1,1);
    for i = 2:m
        b(i, :) = (b(i, :) - L(i, 1:i-1)*b(1:i-1, :))/L(i, i);
    end
end

