clear; clc;
rng(0);

A = [ 1,  3,  1;
     -1, -2,  1;
      3,  7, -1];

p      = 0.1;
lambda = 1e-8;
tol    = 1e-8;

b_a = [10; -5; 20];
x_a = focuss(A, b_a, p, lambda, tol)

b_b = [1; 1; -1];
x_b = focuss(A, b_b, p, lambda, tol)

b_c = [1; 0; 1];
x_c = focuss(A, b_c, p, lambda, tol)

%% Problem 2
clear; clc;
x_true = [1; 0; 1; 1; 0];

p2      = 1;
lambda2 = 1e-3;
tol2    = 10e-7;
maxiter = 1000;

% Base A (a21 = 2)
A2 = [1 2 2 3 1;
      2 4 4 6 2;
      3 6 6 9 6;
      1 2 4 5 3];
b2 = A2 * x_true;

fprintf('\n=== Base A ===\n')
fprintf('rank = %d\n', rank(A2))
Ap2 = pinv(A2)
x_pinv2 = Ap2 * b2
err_pinv2  = norm(x_pinv2 - x_true)
res_pinv2  = norm(A2 * x_pinv2 - b2)

x_foc2  = focuss(A2, b2, p2, lambda2, tol2, maxiter)
err_foc2   = norm(x_foc2 - x_true)
res_foc2   = norm(A2 * x_foc2 - b2)

x_mfoc2 = mfocuss(A2, b2, p2, lambda2, tol2, maxiter)
err_mfoc2  = norm(x_mfoc2 - x_true)
res_mfoc2  = norm(A2 * x_mfoc2 - b2)

% Modified A (a21 = 0)
A2m = A2; A2m(2,1) = 0;
b2m = A2m * x_true;

fprintf('\n=== Modified A (a21 = 0) ===\n')
fprintf('rank = %d\n', rank(A2m))
Ap2m = pinv(A2m)
x_pinv2m = Ap2m * b2m
err_pinv2m = norm(x_pinv2m - x_true)
res_pinv2m = norm(A2m * x_pinv2m - b2m)

x_foc2m  = focuss(A2m, b2m, p2, lambda2, tol2, maxiter)
err_foc2m  = norm(x_foc2m - x_true)
res_foc2m  = norm(A2m * x_foc2m - b2m)

x_mfoc2m = mfocuss(A2m, b2m, p2, lambda2, tol2, maxiter)
err_mfoc2m = norm(x_mfoc2m - x_true)
res_mfoc2m = norm(A2m * x_mfoc2m - b2m)
