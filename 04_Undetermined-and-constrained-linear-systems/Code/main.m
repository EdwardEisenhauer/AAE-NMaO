%% Problem 1
clear;
clc;

A = [ 1,  3,  1;
     -1, -2,  1;
      3,  7, -1];
b = [10;
     -5;
     20];

p = 0.5;
lambda = 1;

focuss(A, b, p, lambda)

%% Functions
function focuss(A, b, p, l)
% Apply the FOCal Undetermined System Solver.
%   Arguments:
%     A --- Coefficient matrix.
%     b --- Column vector of constant terms.
% If p is close to 0 
%     l --- Regularization parameter.

% Affine Scaling Transformation (AST)

[m, ~] = size(A);
[~, n] = size(b);

x = rand(m,n)

N = 3;

for k = 1:N - 1
    W = diag( abs(x).^(1-p/2) )
    x = W^2 * A' * inv(A * W^2 * A' + l*eye(m)) * b
end

end
