function [x, r_err, k] = landweber(A, b,  alpha, x_init, ...
                                   k_max, tolerance, x_real)
% LANDWEBER The Landweber iterative method.
%
%   x = LANDWEBER(A, b) Returns the approximate solution
%     to the system Ax=b.
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.
%     alpha --- The relaxation parameter.
%     x_init --- An initial guess of the solution vector.
%     k_max --- Maximum number of iterations.
%     tolerance --- Error tolerance for convergence.
%     x_real --- The real solution.
arguments
  A (:,:)
  b (:,1)
  alpha double {mustBePositive}
  x_init (:,1)
  k_max {mustBePositive}
  tolerance {mustBePositive}
  x_real (:,1)
end

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

ATA = A' * A;
alpha_max = 2 / norm( max( eigs( ATA ) ) );
% alpha_max = 2/norm(eigs(A,1)*(A'*A));
if alpha > alpha_max
    error('Alpha cannot be greater than %d!', alpha_max)
end

x = x_init;
r_err = NaN(k_max);

for k = 1:k_max
    x_prev = x;
    r_err(k) = norm(x_real - x) / n;
    x = x_prev + alpha * A' * (b - A*x_prev);

    if r_err(k) < tolerance
        fprintf('The Landweber method converged successfully after %d iterations.\n', k);
        break;
    end
end

if k == k_max
    warning('The maximum number of %d iterations reached %s', k_max, ...
            'during approximating with the Landweber method!');
end

end
