function b = Alg4(U,b)
% Argorithm 4: Back Substitution 
% b = Alg4_back_substitution(U,b) returns vetor b with solution to the
% Ux = b.

[m, n] = size(U);

if U ~= triu(U)
    error('Matrix U is not upper triangular!')
end

if m ~= n
    error('Matrix is not squared!')
end

if length(b) ~= m
    error('Vector b has wrong length!')
end

% if det(U) < eps
%     error('Matrix is not nonsingular!')
% end


% The following algorithm is based on the Algrotihm 3.1.2 from [2].

% b(m, :) so that matrices are also accepted
b(m, :) = b(m, :)/U(m, m);
for i = m-1:-1:1
    b(i, :) = (b(i, :) - U(i, i+1 : m)*b(i+1 : m, :))/U(i, i);
end

end