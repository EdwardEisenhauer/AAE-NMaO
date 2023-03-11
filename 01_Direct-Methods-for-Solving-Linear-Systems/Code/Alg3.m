function b = Al3(L, b)
% Algorithm 3: Forward Substitution
% b = Alg3_forward_substitution(L, b) overwrites b with the solution to
% Lx = b.

[m, n] = size(L);

if m ~= n
    error('Matrix is not square!')
end

if length(b) ~= m
    error('Vector b has wrong length!')
end

if det(L) < eps
    error("Matrix is not nonsingular!")
end

% The following algorithm is based on the Algrotihm 3.1.1 from [2].

% b(m, :) so that matrices are also accepted
b(1, :) = b(1, :)/L(1,1);
for i = 2:m
    b(i, :) = (b(i, :) - L(i, 1:i-1)*b(1:i-1, :))/L(i, i);
end

end

