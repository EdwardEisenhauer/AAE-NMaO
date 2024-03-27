function [lambda, lambdaValues, convergenceRates] = ScaledPowerMethod(A, iter, epsilon)
    n = size(A,1);
    xi = rand(n, 1);
    xi = xi / norm(xi);  
    lambdaValues = zeros(iter,1);
    convergenceRates = zeros(iter,1);
    for i = 1:iter
        Ax = A * xi;
        lambda = norm(Ax);
        lambdaValues(i) = lambda;
        
        xi_next = Ax / lambda;
        convergenceRates(i) = norm(xi_next - xi);
        if convergenceRates(i) < epsilon
            convergenceRates = nonzeros(convergenceRates);
            lambdaValues = nonzeros(lambdaValues);
            break;
        end
        xi = xi_next;
    end
end
