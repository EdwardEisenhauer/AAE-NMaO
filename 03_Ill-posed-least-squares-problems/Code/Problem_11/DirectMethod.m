function [theta_hat] = DirectMethod(x, y, param_num)
    A = zeros(length(x), param_num);
    for i = 1:length(x)
        for j = 1:param_num
            A(i,j) = x(i)^(j-1);
        end
    end
    
    theta_hat = (A' * A) \ (A' * y');
end
