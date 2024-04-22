%% Problem 1
clear; 
clc;
% 2u -  v           = 0
% -u + 2v -  w      = 0
%      -v + 2w -  z = 0
%           -w + 2z = 5
A = [ 2, -1,  0,  0;
     -1,  2, -1,  0;
      0, -1,  2, -1;
      0,  0, -1,  2];
b = [0;
     0;
     0;
     5];
% As this is the same system as the one ine the List 1 Problem 1:
x_exact = A\b;
% Following the suggestion from the Problem's description
x_init = zeros(size(A,2), 1);
% Landweber (gradient descent)
n = length(A)
alpha = 0.1
G = eye(n) - alpha * A' * A
k = 50
e_0 = abs(x_init - x_exact)
e = G^k * e_0

results = struct;
errors = struct;
[results.landweber, errors.landweber] = landweber(A, b, x_init, k, 1e-6, A\b, alpha)
[results.jacobi, errors.jacobi] = jacobi(A, b, x_init, k, 1e-6, A\b);

plot(1:k,errors.landweber,1:k,errors.jacobi)
xlabel("Iteration")
ylabel("Residual error")
legend("Landweber", "Jacobi")

return

%% Problem 2
clear all;
clc;
A = [1, 1, 1;
     1, 1, 2;
     1, 2, 2];
b = [1;2;1];

x_init = zeros(size(A,2), 1);

[x, r_err] = landweber(A, b, x_init, 50, 1e-6, A\b, 10);

figure
plot(r_err)
title("Landweber")
xlabel("Iteration")
ylabel("Residual error")

return

[x, r_err] = jacobi(A, b, x_init, 50, 1e-6, A\b);

figure
plot(r_err)
title("Jacobi")
xlabel("Iteration")
ylabel("Residual error")

[x, r_err] = gaussSeidel(A, b, x_init, 50, 1e-6, A\b);

figure
plot(r_err)
title("Gauss-Seidel")
xlabel("Iteration")
ylabel("Residual error")

[x, r_err] = sor(A, b, x_init, 50, 1e-6, A\b, 0.1);

figure
plot(r_err)
title("SOR")
xlabel("Iteration")
ylabel("Residual error")
