function [x, r_err] = kaczmarz(A, b, x_init, maxIterations, tolerance, x_real)
    % KACZMARZ The Kaczmarz iterative method.
    %
    %   x = KACZMARZ(A, b) approximates a solution to the system A*x=b.
    %
    %   Arguments:
    %     A --- Coefficient matrix.
    %     b --- Column vector of constant terms.
    %     x_init --- An initial guess of the solution vector.
    %
    % Input:
    %   maxIterations: Maximum number of iterations
    %   tolerance: Error tolerance for convergence
    %   x_real: The real solution vector for error comparison
    
        [m, n] = size(A);
        
        if length(b) ~= m
            error('Vector b has wrong length!')
        end
        
        x = x_init;
        r_err = zeros(maxIterations, 1);
        
        for k = 1:maxIterations
            for i = 1:m
                a_i = A(i, :)';
                x = x + (b(i) - a_i' * x) / (norm(a_i)^2) * a_i;
            end
            
            r_err(k) = norm(x_real - x) / n;
            
            if r_err(k) < tolerance
                fprintf('Converged successfully after %d iterations.\n', k);
                break;
            end
        end
        
        if k == maxIterations
            disp('Maximum number of iterations reached.');
        end
    
    end