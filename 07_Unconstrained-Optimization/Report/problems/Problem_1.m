f = @(x1, x2) 100*(x2 - x1.^2).^2 + (1 - x1).^2;
x = [1; 1];

% First-order condition: gradient at x*
df_dx1 = -400*x(1)*(x(2) - x(1)^2) - 2*(1 - x(1));
df_dx2 = 200*(x(2) - x(1)^2);
grad = [df_dx1; df_dx2];

% Second-order condition: Hessian at x*
H11 = 1200*x(1)^2 - 400*x(2) + 2;
H12 = -400*x(1);
H = [H11, H12; H12, 200];
eigenvalues_H = eig(H);

% Contour plot
x1r = linspace(-1.5, 1.5, 400);
x2r = linspace(-0.5, 1.5, 400);
[X1, X2] = meshgrid(x1r, x2r);
F = f(X1, X2);

figure;
contour(X1, X2, F, logspace(-1, 3, 30));
hold on;
plot(1, 1, 'r*', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('x_1'); ylabel('x_2');
title('Rosenbrock function');
colorbar;
