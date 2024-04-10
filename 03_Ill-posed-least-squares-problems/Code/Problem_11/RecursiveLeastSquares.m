function [theta_hat] = RecursiveLeastSquaresImproved(x, y, param_num)
    n = length(x);
    theta_hat = zeros(param_num, 1);
    P = 1000 * eye(param_num);
    lambda = 0.99;
    for i = 1:n
        phi = zeros(param_num, 1);
        for j = 1:param_num
            phi(j) = x(i)^(j-1);
        end
        P = (P - (P * (phi * phi') * P) / (lambda + phi' * P * phi)) / lambda;       
        K = P * phi;
        theta_hat = theta_hat + K * (y(i) - phi' * theta_hat);
    end
end
