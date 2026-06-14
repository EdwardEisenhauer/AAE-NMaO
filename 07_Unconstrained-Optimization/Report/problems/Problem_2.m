% Quadratic functions and their Hessians
Ga = [4, -1; -1, 1];
Gb = [-3, 1; 1, -1];
Gc = [2, 8; 8, 1];

% Stationary points: G*x = -c
xa = Ga \ [3; 0];
xb = Gb \ [-2; 0];
xc = Gc \ [10; 9];

% Eigenvalues for classification
eig_Ga = eig(Ga);
eig_Gb = eig(Gb);
eig_Gc = eig(Gc);

% Contour plots
x1r = linspace(-1, 3, 300);
x2r = linspace(-1, 3, 300);
[X1, X2] = meshgrid(x1r, x2r);

fa = @(x1, x2) 2*x1.^2 - x1.*x2 + 0.5*x2.^2 - 3*x1 + 3.5;
fb = @(x1, x2) -1.5*x1.^2 + x1.*x2 - 0.5*x2.^2 + 2*x1 - 1;
fc = @(x1, x2) x1.^2 + 8*x1.*x2 + 0.5*x2.^2 - 10*x1 - 9*x2 + 4.5;

figure('Position', [0, 0, 1200, 380]);
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
