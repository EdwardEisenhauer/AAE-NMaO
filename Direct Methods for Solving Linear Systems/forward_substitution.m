% Algorithm 3: Forward Substitution (Alg. 3.1.1)
function b = forward_substitution(L, b)

[n, m] = size(L);
if n ~= m
    error('Matrix is not squared!')
end

if length(b) ~= n
    error('Vector b has wrong length!')
end

b(1) = b(1)/L(1,1);
for i = 2:n
    b(i) = (b(i) - L(i, 1:i-1)*b(1:i-1))/L(i, i);
end

