function [x, r_err] = sor(A, b, initialGuess, maxIterations, tolerance, x_real, omega)
% Input:
%   A: Coefficient matrix of the linear equation system
%   b: Right-hand side vector of the linear equation system
%   initialGuess: Initial guess for the solution vector
%   maxIterations: Maximum number of iterations
%   tolerance: Error tolerance for convergence

n = length(b);
x = initialGuess;
r_err = NaN(maxIterations);
S = tril(A) + diag(diag(A)) ./ omega;
T = S - A
G = inv(S)*T

for k = 1:maxIterations
    x_prev = x;
    r_err(k) = norm(x_real - x)/n;
    x = inv(S)*(T*x_prev + b);

    if r_err(k) < tolerance
        disp(sprintf('Converged successfully after %d iterations.', k));
        break;
    end
end

if k == maxIterations
    disp('Maximum number of iterations reached.');
end

end
