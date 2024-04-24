function [x, r_err] = jacobi(A, b, x_init, maxIterations, tolerance, x_real)
% JACOBI The Jaboci iterative method.
%
%   x = JACOBI(A, b) approximates a solution to the system A*x=b.
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.
%     x_init --- An initial guess of the solution vector.
% Input:
%   A: Coefficient matrix of the linear equation system
%   b: Right-hand side vector of the linear equation system
%   initialGuess: Initial guess for the solution vector
%   maxIterations: Maximum number of iterations
%   tolerance: Error tolerance for convergence

[m, n] = size(A);

if m ~= n
    error('The coefficient matrix A is not square!')
end

if det(A) < eps
    error('The coefficient matrix A is singular!')
end

if length(b) ~= n
    error('Vector b has wrong length!')
end

x = x_init;
r_err = NaN(maxIterations);

S = diag(diag(A))
T = S - A

for k = 1:maxIterations
    x_prev = x;
    r_err(k) = norm(x_real - x)/n;
    x = inv(S)*(T*x_prev + b);

    if r_err(k) < tolerance
        fprintf('Converged successfully after %d iterations.\n', k);
        break;
    end
end

if k == maxIterations
    fprintf('Maximum number of %d iterations reached!\n', maxIterations);
end

end
