function x = focuss(A, b, p, lambda, tolerance, max_iter)
    [m,n] = size(A);
    x = rand(n,1);
    x_last = inf;
    while tolerance < norm(x_last - x)
        x_last = x;
        W=diag(abs(x).^(1 - p/2));
        x=W*W*A'*(A*W*W*A'+lambda*eye(m))^(-1)*b;
    end
end