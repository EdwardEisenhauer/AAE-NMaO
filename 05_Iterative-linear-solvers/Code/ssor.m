function x = landweber(A, B, omega, initialGuess, maxIterations, tolerance, alpha)
    % Input:
    %   A: Coefficient matrix of the linear equation system
    %   B: Right-hand side vector of the linear equation system
    %   omega: Relaxation parameter (0 < omega < 2)
    %   initialGuess: Initial guess for the solution vector
    %   maxIterations: Maximum number of iterations
    %   tolerance: Error tolerance for convergence
    
    n = length(B);
    x = initialGuess;
    
    for k = 1:maxIterations
        x_prev = x;
        
        for i = 1:n
            sum1 = A(i,1:i-1)*x(1:i-1);
            sum2 = A(i,i+1:n)*x_prev(i+1:n);
            x(i) = (1 - omega) * x_prev(i) + (omega / A(i,i)) * (B(i) - sum1 - sum2);
        end
        
        if norm(A*x - B, inf) < tolerance
            disp('Converged successfully.');
            break;
        end
    end
    
    if k == maxIterations
        disp('Maximum number of iterations reached.');
    end
end
