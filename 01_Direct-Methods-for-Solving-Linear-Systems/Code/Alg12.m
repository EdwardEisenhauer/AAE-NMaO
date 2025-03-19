function [Q, R] = Alg12(A)
% Algorithm 11 - The  QR  algorithm  by  the  Householder  transformation
% [Q, R] = Alg12(A)
% Based on [GVL96]: Algorithm 5.2.4
[m, n] = size(A);

if ~ (m >= n)
   error("m has to be greater or equal n!") 
end

Q = eye(m, m);
for j = 1:n
    for i = m:-1:j+1
        [c, s] = Givens(A(i-1, j), A(i, j));
        A(i-1:i, j:n) = [c s; -s c]'*A(i-1:i, j:n);
        Q(:, i-1:i) = Q(:, i-1:i)*[c s ; -s c];
    end
end
R = A;
  
end