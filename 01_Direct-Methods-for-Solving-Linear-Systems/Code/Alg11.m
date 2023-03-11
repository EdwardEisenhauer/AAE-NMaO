function [Q R] = Alg11(A)
% Algorithm 11: QR factorization via Householder transformation.

[m, n] = size(A);

if ~ (m>=n)
   error("m has to be greater or equal n!") 
end

for j = 1:n
    [v, beta] = householder(A(j:m, j))
    A(j:m, j:n) = (eye(m-j+1)-beta*(v*v.'))*A(j:m, j:n)
    if j < m
        A(j+1:m, j) = v(2:m-j+1)
    end
end

R = triu(A)

H = tril(A, -1)


end

