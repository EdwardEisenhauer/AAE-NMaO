function [lambda, lambdaValues, convergenceRates]...
    = InversePowerMethod(A, s, iter, epsilon)
    n = size(A, 1);
    xi = rand(n, 1);
    I = eye(n);  
    lambdaValues = zeros(iter,1);
    convergenceRates = zeros(iter,1);
    for k = 1:iter
        y = mldivide((A - s*I), xi);
        mu = norm(y, 2);
        y = y / mu;
        lambdaValues(k) = s + 1/mu;
        convergenceRates(k) = norm(xi - y, 2);
        if norm(xi - y, 2) < epsilon
            lambda = s + 1/mu;
            convergenceRates = nonzeros(convergenceRates);
            lambdaValues = nonzeros(lambdaValues);
            return;
        end
        xi = y; 
    end
    lambda = s + 1/mu;
end

