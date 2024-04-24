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
x_exact = A\b
% Calculating the spectral radii for each method
n = length(A);
% Landweber (gradient descent)
alpha = 0.04;
G_landweber = eye(n) - alpha * (A' * A);
rho_landweber = eigs(G_landweber, 1, 'lm')
% Jacobi
S_jacobi = diag(diag(A));
G_jacobi = eye(n) - inv(S_jacobi)*A;
rho_jacobi = eigs(G_jacobi, 1, 'lm')
% Gauss-Seidel
S_gauss_seidel = tril(A);
G_gauss_seidel = eye(n) - inv(S_gauss_seidel)*A;
rho_gauss_seidel = eigs(G_gauss_seidel, 1, 'lm')
% Successive Over-Relaxation (SOR)
omega = 1;
S_sor = tril(A,-1) + diag(diag(A))/omega;
G_sor = eye(n) - inv(S_sor)*A;
rho_sor = eigs(G_sor, 1, 'lm')

% Following the suggestion from the Problem's description
x_init = zeros(n, 1);
k = 100;

[x_landweber, e_landweber] = landweber(A, b, x_init, k, 1e-6, A\b, alpha);
[x_jacobi, e_jacobi] = jacobi(A, b, x_init, k, 1e-6, A\b);
[x_gauss_seidel, e_gauss_seidel] = gaussSeidel(A, b, x_init, k, 1e-6, A\b);
[x_sor, e_sor] = sor(A, b, x_init, k, 1e-6, A\b, 0.1);
plot(1:k,e_landweber,1:k,e_jacobi,1:k,e_gauss_seidel,1:k,e_sor)
xlabel("Iteration")
ylabel("Solution error")
legend("Landweber", "Jacobi", "Gauss-Seidel", "SOR")


e_0 = abs(x_init - x_exact);
e_landweber = norm(G_landweber^k * e_0);
e_jacobi = norm(G_jacobi^k * e_0);

e_gauss_seidel = norm(G_gauss_seidel^k * e_0);

e_sor = norm(G_sor^k * e_0);

methods = struct;
methods.landweber.G = eye(n) - alpha * A' * A;
methods.landweber.residual_norm = norm(methods.landweber.G^k * abs(x_init - x_exact));
[methods.landweber.x, methods.landweber.errors] = landweber(A, b, x_init, k, 1e-6, A\b, alpha);
% [methods.jacobi.x, errors.jacobi] = jacobi(A, b, x_init, k, 1e-6, A\b);



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
