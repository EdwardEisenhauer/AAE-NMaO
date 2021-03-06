% Argorithm 4: Back Substitution (Alg. 3.1.2)
function back_substitution(U,b)

[n, m] = size(U);
if n ~= m
    error('Matrix is not squared!')
end

if length(b) ~= n
    error('Vector b has wrong length!')
end

if det(U) == 0
    error('Matrix is not nonsingular!')
end

b(n) = b(n)/U(n, n)
for i = n-1:-1:1
    b(i) = (b(i) - U(i, i+1 : n)*b(i+1 : n))/U(i, i)
end

end