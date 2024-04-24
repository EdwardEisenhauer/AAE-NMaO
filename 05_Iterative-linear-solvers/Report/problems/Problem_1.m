A = [ 2, -1,  0,  0;
     -1,  2, -1,  0;
      0, -1,  2, -1;
      0,  0, -1,  2];
b = [0;
     0;
     0;
     5];
x_exact = A\b

x_exact =

    1.0000
    2.0000
    3.0000
    4.0000
% As this is the same system as the one ine the List 1 Problem 1:
% Following the suggestion from the Problem's description
x_init = zeros(size(A,2), 1);
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

rho_landweber =

     0.9942


rho_jacobi =

    0.8090


rho_gauss_seidel =

    0.6545


rho_sor =

    0.6545

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
