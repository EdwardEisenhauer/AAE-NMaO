function back_substitution(U,b)

[n, m] = size(U);
if n ~= m
    error('Matrix is not squared!')
end

if length(b) ~= n
    error('Vector b has wrong length!')
end

if det(A) == 0
    error('Matrix is not nonsingular!') 
end

b(n) = b(n)/U(n, n)
for i = n-1:-1:n
    
end

end