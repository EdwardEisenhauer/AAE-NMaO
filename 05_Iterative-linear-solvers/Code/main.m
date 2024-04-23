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
n = length(A);
k = 100;
% As this is the same system as the one ine the List 1 Problem 1:
x_exact = A\b;
% Following the suggestion from the Problem's description
x_init = zeros(size(A,2), 1);
% Landweber (gradient descent)
alpha = 2/norm(eigs(A,1)*(A'*A));
G_landweber = eye(n) - alpha * (A' * A);
e_0 = abs(x_init - x_exact);
e_landweber = norm(G_landweber^k * e_0)
% Jacobi
S_jacobi = diag(diag(A));
G_jacobi = eye(n) - inv(S_jacobi)*A;
e_jacobi = norm(G_jacobi^k * e_0)
% Gauss-Seidel
S_gauss_seidel = tril(A);
G_gauss_seidel = eye(n) - inv(S_gauss_seidel)*A;
e_gauss_seidel = norm(G_gauss_seidel^k * e_0)
% Successive Over-Relaxation (SOR)
omega = 1;
S_sor = tril(A,-1) + diag(diag(A))/omega;
G_sor = eye(n) - inv(S_sor)*A;
e_sor = norm(G_sor^k * e_0)

methods = struct;
methods.landweber.G = eye(n) - alpha * A' * A;
methods.landweber.residual_norm = norm(methods.landweber.G^k * abs(x_init - x_exact));
[methods.landweber.x, methods.landweber.errors] = landweber(A, b, x_init, k, 1e-6, A\b, alpha);
% [methods.jacobi.x, errors.jacobi] = jacobi(A, b, x_init, k, 1e-6, A\b);

% plot(1:k,errors.landweber,1:k,errors.jacobi)
% xlabel("Iteration")
% ylabel("Residual error")
% legend("Landweber", "Jacobi")

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
