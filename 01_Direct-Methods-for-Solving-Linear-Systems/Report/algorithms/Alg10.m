function A = Alg10(A)
% Algorithm 10: Cholesky (Banachiewicz) factorization.
% Matrix A has to be symmetric and positive-definite:
% all d(i, i) > 0 for A = LDL^T.
% We are using Outer product Version (Golub, Load, Alg. 4.2.2), which
% computes lower triangular G, such that A = G*G^T

[m, n] = size(A);

if m ~= n
    error('Matrix is not square!')
end

for k = 1:m
   A(k,k) = sqrt(A(k,k));
   A(k+1:n, k) = A(k+1:n, k)/A(k,k);
   for j = k+1:n
       A(j:n, j) = A(j:n, j) - A(j:n, k)*A(j, k);
   end
end

A = tril(A);

end