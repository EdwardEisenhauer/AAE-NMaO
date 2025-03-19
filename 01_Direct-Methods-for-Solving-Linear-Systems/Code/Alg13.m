function [Q, R] = Alg13(A)
% Algorithm 13: The QR algorithm by the Gram-Schmidt ortogonalization
% [Q, R] = Alg13(A)
% Based on [GVL96]: Section 5.2.8

[m,n] = size(A);

if ~ (m >= n)
   error("m has to be greater or equal n!") 
end

R = zeros(n, n);
Q = zeros(m, n);
for k = 1:n
    R(k, k) = norm(A(:, k));
    Q(:, k) = A(:, k)/R(k, k);
    R(k, k+1:n) = Q(:, k)'*A(:, k+1:n);
    A(:, k+1:n) = A(:, k+1:n) - Q(:, k)*R(k, k+1:n);
end