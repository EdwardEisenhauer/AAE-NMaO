function [x, r_err] = landweber(A, b, x_init, maxIterations, tolerance, x_real, alpha)
% LANDWEBER The Landweber iterative method.
%
%   x = LANDWEBER(A, b) approximates a solution to the system A*x=b.
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.
%     x_init --- An initial guess of the solution vector.
%     alpha --- The relaxation parameter.
%
% Input:
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

if alpha < 0
    error('Alpha cannot be smaller than 0!')
end

alpha_max = 2/norm(eigs(A,1)*(A'*A));
if alpha > alpha_max
    error('Alpha cannot be greater than %d!', alpha_max)
end

x = x_init;
r_err = NaN(maxIterations);

for k = 1:maxIterations
    x_prev = x;
    r_err(k) = norm(x_real - x)/n;
    x = x_prev + alpha * A' * (b - A*x_prev);

    if r_err(k) < tolerance
        fprintf('Converged successfully after %d iterations.\n', k);
        break;
    end
end

if k == maxIterations
    fprintf('Maximum number of %d iterations reached!\n', maxIterations);
end

end
