%% Lab 07 - Unconstrained Optimization
% Sergiusz Warga 230757
clear; clc;

%% Problem 1 - Rosenbrock function: optimality conditions and contour plot
f = @(x1, x2) 100*(x2 - x1.^2).^2 + (1 - x1).^2;
x = [1; 1];

% First-order condition: gradient at x*
df_dx1 = -400*x(1)*(x(2) - x(1)^2) - 2*(1 - x(1));
df_dx2 = 200*(x(2) - x(1)^2);
grad = [df_dx1; df_dx2];

fprintf('=== Problem 1: Rosenbrock ===\n');
fprintf('Gradient at x*=[1,1]: [%.4f; %.4f]\n', grad(1), grad(2));

% Second-order condition: Hessian at x*
H11 = 1200*x(1)^2 - 400*x(2) + 2;
H12 = -400*x(1);
H = [H11, H12; H12, 200];
eigenvalues_H = eig(H);
fprintf('Hessian eigenvalues: %.4f, %.4f  (both > 0: pos. def.)\n\n', ...
    eigenvalues_H(1), eigenvalues_H(2));

% Contour plot
x1r = linspace(-1.5, 1.5, 400);
x2r = linspace(-0.5, 1.5, 400);
[X1, X2] = meshgrid(x1r, x2r);
F = f(X1, X2);

fig1 = figure('Visible', 'off');
contour(X1, X2, F, logspace(-1, 3, 30));
hold on;
plot(1, 1, 'r*', 'MarkerSize', 10, 'LineWidth', 2);
xlabel('x_1'); ylabel('x_2');
title('Rosenbrock function');
colorbar;
print(fig1, '../Report/images/Contour_Problem1.png', '-dpng', '-r150');

%% Problem 2 - Quadratic functions: stationary points and classification
Ga = [4, -1; -1, 1];
Gb = [-3, 1; 1, -1];
Gc = [2, 8; 8, 1];

xa = Ga \ [3; 0];
xb = Gb \ [-2; 0];
xc = Gc \ [10; 9];

eig_Ga = eig(Ga);
eig_Gb = eig(Gb);
eig_Gc = eig(Gc);

fprintf('=== Problem 2: Quadratic functions ===\n');
fprintf('x*_a = [%.4f; %.4f]  eig(Ga) = [%.4f, %.4f]  -> minimizer\n', ...
    xa(1), xa(2), eig_Ga(1), eig_Ga(2));
fprintf('x*_b = [%.4f; %.4f]  eig(Gb) = [%.4f, %.4f]  -> maximizer\n', ...
    xb(1), xb(2), eig_Gb(1), eig_Gb(2));
fprintf('x*_c = [%.4f; %.4f]  eig(Gc) = [%.4f, %.4f]  -> saddle\n\n', ...
    xc(1), xc(2), eig_Gc(1), eig_Gc(2));

% Contour plots
x1r2 = linspace(-1, 3, 300);
x2r2 = linspace(-1, 3, 300);
[X1, X2] = meshgrid(x1r2, x2r2);

fa = @(x1, x2) 2*x1.^2 - x1.*x2 + 0.5*x2.^2 - 3*x1 + 3.5;
fb = @(x1, x2) -1.5*x1.^2 + x1.*x2 - 0.5*x2.^2 + 2*x1 - 1;
fc = @(x1, x2) x1.^2 + 8*x1.*x2 + 0.5*x2.^2 - 10*x1 - 9*x2 + 4.5;

fig2 = figure('Visible', 'off', 'Position', [0, 0, 1200, 380]);
subplot(1, 3, 1);
contour(X1, X2, fa(X1, X2), 20);
hold on; plot(xa(1), xa(2), 'r*', 'MarkerSize', 8, 'LineWidth', 1.5);
xlabel('x_1'); ylabel('x_2'); title('f_a (minimizer)'); colorbar;

subplot(1, 3, 2);
contour(X1, X2, fb(X1, X2), 20);
hold on; plot(xb(1), xb(2), 'r*', 'MarkerSize', 8, 'LineWidth', 1.5);
xlabel('x_1'); ylabel('x_2'); title('f_b (maximizer)'); colorbar;

subplot(1, 3, 3);
contour(X1, X2, fc(X1, X2), 20);
hold on; plot(xc(1), xc(2), 'r*', 'MarkerSize', 8, 'LineWidth', 1.5);
xlabel('x_1'); ylabel('x_2'); title('f_c (saddle point)'); colorbar;

print(fig2, '../Report/images/Contour_Problem2.png', '-dpng', '-r150');
