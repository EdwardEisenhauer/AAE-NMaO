function [x, r_err] = gaussSeidel(A, b, initialGuess, maxIterations, tolerance, x_real)
% Input:
%   A: Coefficient matrix of the linear equation system
%   b: Right-hand side vector of the linear equation system
%   initialGuess: Initial guess for the solution vector
%   maxIterations: Maximum number of iterations
%   tolerance: Error tolerance for convergence

n = length(b);
x = initialGuess;
r_err = zeros(n,1);
S = tril(A)
T = S - A
G = inv(S)*T

for k = 1:maxIterations
    x_prev = x;
    r_err(k) = norm(x_real - x)/n;
 
    for i = 1:n
        x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:n)*x_prev(i+1:n)) / A(i,i);
    end
    % x_2 = inv(S)*(T*x_prev + b);
 

    if r_err(k) < tolerance
        disp(sprintf('Converged successfully after %d iterations.', k));
        break;
    end
end

if k == maxIterations
    disp('Maximum number of iterations reached.');
end

end
