%% Problem 1
clear;
clc;

A = [ 1,  3,  1;
     -1, -2,  1;
      3,  7, -1];
b = [10;
     -5;
     20];

p = 0.1;
lambda = 10^-8;

x = focuss(A, b, p, lambda)

b - A*x

%% Functions
function x = focuss(A, b, p, l)
% Apply the FOCal Undetermined System Solver.
%   Arguments:
%     A --- Coefficient matrix.
%     b --- Column vector of constant terms.
% If p is close to 0 
%     l --- Regularization parameter.

% Affine Scaling Transformation (AST)

if p > 1 || p <= 0
     error("p has to be in range (0, 1]")
end

[m, ~] = size(A);
[~, n] = size(b);

x = rand(m,n)

N = 10;

for k = 1:N - 1
    W = diag( abs(x).^(1-p/2) )
%     x = W^2 * A' * inv(A * W^2 * A' + l*eye(m)) * b
     % Based on Zdunek
  x_bar = (A*W)' * inv( A*W * (A*W)' + l * eye(m) ) * b
  x = W*x_bar
end

end

% The best way for implementation
% A_bar = A* W
% A_bar^T * (A_bar * A_bar^T * + lambda * I)^-1 * b
