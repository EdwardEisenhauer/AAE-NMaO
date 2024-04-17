function x = mfocuss(A, b, p, lambda, tolerance, max_iter)
    [m, n] = size(A);
    x = randn(n, 1); 
    x_last = inf(n, 1); 
    for k = 1:max_iter
        W = diag(abs(x).^(1 - p/2));
        x_new = (W * A') / (A * W^2 * A' + lambda * eye(m)) * b;
        if norm(x_new - x_last, 2) < tolerance
            break;
        end     
        x_last = x;
        x = x_new;
    end
end
