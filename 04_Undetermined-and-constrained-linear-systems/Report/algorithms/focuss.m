function x = focuss(A, b, p, lambda, tol, max_iter)
    if nargin < 6, max_iter = 10000; end
    [m, n] = size(A);
    x      = rand(n, 1);
    x_prev = inf(n, 1);
    k      = 0;
    while norm(x - x_prev) > tol
        x_prev = x;
        W = diag(abs(x).^(1 - p/2));
        x = W^2 * A' * (A * W^2 * A' + lambda * eye(m))^(-1) * b;
        k = k + 1;
        if mod(k, 100) == 0
            fprintf('iter %d  ||dx|| = %.2e\n', k, norm(x - x_prev));
        end
        if k >= max_iter
            fprintf('FOCUSS: reached max_iter = %d\n', max_iter);
            break;
        end
    end
end
