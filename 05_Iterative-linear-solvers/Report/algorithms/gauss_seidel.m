function [x, r_err] = gauss_seidel(A, b, x_init, k_max, tolerance, x_real)
% GAUSS__SEIDEL
%
%   Arguments:
%     A --- Square coefficient matrix.
%     b --- Column vector of constant terms.
%     x_init --- An initial guess of the solution vector.
%     k_max --- Maximum number of iterations.
%     tolerance --- Error tolerance for convergence.

n = length(b);
x = x_init;
r_err = NaN(k_max);
S = tril(A);
T = S - A;

for k = 1:k_max
    x_prev = x;
    r_err(k) = norm(x_real - x)/n;

    for i = 1:n
        x(i) = (b(i) - A(i,1:i-1)*x(1:i-1) - A(i,i+1:n)*x_prev(i+1:n)) / A(i,i);
    end
    % x_2 = inv(S)*(T*x_prev + b);


    if r_err(k) < tolerance
        fprintf(['The Gauss-Seidel iterative method converged successfully' ...
            ' after %d iterations!\n'], k);
        break;
    end
end

if k == k_max
    fprintf('Maximum number of %d iterations reached!\n', k_max);
end

end
