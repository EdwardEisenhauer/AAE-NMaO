function b = Alg4_back_substitution(U,b)
% ADDME Argorithm 4: Back Substitution (Golub, Loan, Alg. 3.1.2)
% Returns vetor b with solution to he Ux = b.

[m, n] = size(U);

if U ~= triu(U)
    error('Matrix is not upper triangular!')
end

if m ~= n
    error('Matrix is not squared!')
end

if length(b) ~= m
    error('Vector b has wrong length!')
end

% if det(U) < 0.001
%     error('Matrix is not nonsingular!')
% end

% b(m, :) so that matrices are also accepted

b(m, :) = b(m, :)/U(m, m);
for i = m-1:-1:1
    b(i, :) = (b(i, :) - U(i, i+1 : m)*b(i+1 : m, :))/U(i, i);
end

end