%% Define system F(x) = 0
F = @(x) [2*x(1) - x(2) - exp(-x(1));
          -x(1) + 2*x(2) - exp(-x(2))];
J = @(x) [2 + exp(-x(1)),  -1;
          -1,               2 + exp(-x(2))];

%% Newton's method
x0   = [-5; -5];
x    = x0;
path = x.';
tol  = 1e-12;

for k = 1:50
    p = -J(x) \ F(x);
    x = x + p;
    path(end+1,:) = x.'; %#ok<AGROW>
    if norm(p) < tol, break; end
end

fprintf('Newton solution: x = (%.10f, %.10f)\n', x(1), x(2));
fprintf('Residual:        ||F(x)|| = %.2e\n', norm(F(x)));
fprintf('Iterations:      %d\n', size(path,1)-1);

%% fsolve verification
opts  = optimoptions('fsolve', 'Display', 'off', 'TolFun', 1e-14, 'TolX', 1e-14);
x_fs  = fsolve(F, x0, opts);
fprintf('fsolve solution: x = (%.10f, %.10f)\n', x_fs(1), x_fs(2));

%% Plot: zero-contours of F1, F2 and Newton path
x1v = linspace(-6, 2, 600);
x2v = linspace(-6, 2, 600);
[X1, X2] = meshgrid(x1v, x2v);
Z1 = 2*X1 - X2 - exp(-X1);
Z2 = -X1 + 2*X2 - exp(-X2);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [0 0 14 12]);
hold on;
contour(X1, X2, Z1, [0 0], 'b', 'LineWidth', 1.8, 'DisplayName', '$F_1 = 0$');
contour(X1, X2, Z2, [0 0], 'r', 'LineWidth', 1.8, 'DisplayName', '$F_2 = 0$');
plot(path(:,1), path(:,2), 'k-o', 'MarkerSize', 5, 'LineWidth', 1.2, ...
    'DisplayName', 'Newton iterates');
plot(x(1), x(2), 'k*', 'MarkerSize', 12, 'LineWidth', 2, ...
    'DisplayName', '$\mathbf{x}^*$');
hold off;

xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$x_2$', 'Interpreter', 'latex');
legend('Location', 'northwest', 'Interpreter', 'latex', 'FontSize', 10);
axis tight;
grid on;

[~,~] = mkdir('images');
print(fig, 'images/Iter_Problem3', '-dpng', '-r150');
close(fig);
