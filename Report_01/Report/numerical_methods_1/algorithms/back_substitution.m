function b = back_substitution(U,b)
% BACK_SUBSTITUTION Back substitution.
%
%   b = back_substitution(U,b) Returns a vector b with the solution to the
%     Ux = b.
%
%   Arguments:
%     U --- Upper triangular matrix of coefficients.
%     b --- Column vector of constant terms.

[m, n] = size(U);

if U ~= triu(U)
    error('The coefficient matrix U is not upper triangular!')
end

if m ~= n
    error('The coefficient matrix U is not square!')
end

if length(b) ~= m
    error('The constant terms vector b has wrong length!')
end

if det(U) < eps
    error('Matrix U is not nonsingular!')
end

b(m) = b(m) / U(m, m);
for i = m - 1:-1:1
    b(i) = ( b(i) - U(i, i+1:m) * b(i + 1:m) ) / U(i, i);
end

end
