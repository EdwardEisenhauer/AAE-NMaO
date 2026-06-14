syms x1 x2

F1 = x1^3 + 3*x1^2 + 3*x1 - x2;
F2 = x1^2  + 2*x1  - x2 + 1;
F  = [F1; F2];

f  = F.' * F / 2;
J  = jacobian(F, [x1, x2]);
gf = simplify(J.' * F);
H  = hessian(f, [x1, x2]);

sol = solve(gf == 0, [x1, x2]);
a1  = double(sol.x1);
a2  = double(sol.x2);

for k = 1:numel(a1)
    if ~isreal(a1(k)) || ~isreal(a2(k)), continue; end
    fval = double(subs(f, {x1, x2}, {a1(k), a2(k)}));
    Hk   = double(subs(H, {x1, x2}, {a1(k), a2(k)}));
    M1   = Hk(1,1);
    dH   = det(Hk);
    fprintf('x = (%.5f, %.5f),  f = %.6f\n', a1(k), a2(k), fval);
    fprintf('  H = [%.4f %.4f; %.4f %.4f]\n', Hk(1,1), Hk(1,2), Hk(2,1), Hk(2,2));
    fprintf('  M1 = %.4f,  det(H) = %.4f\n', M1, dH);
    if dH > 0 && M1 > 0 && abs(fval) < 1e-8
        disp('  => Global minimum');
    elseif dH > 0 && M1 > 0
        disp('  => Local minimum (spurious)');
    elseif dH < 0
        disp('  => Saddle point');
    end
    fprintf('\n');
end

% --- Contour plot of the objective function ---
x1v = linspace(-2.5, 1.5, 500);
x2v = linspace(-2.0, 4.0, 500);
[X1, X2] = meshgrid(x1v, x2v);

F1n = X1.^3 + 3*X1.^2 + 3*X1 - X2;
F2n = X1.^2 + 2*X1 - X2 + 1;
fn  = 0.5*(F1n.^2 + F2n.^2);
fn  = min(fn, 2);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [0 0 16 12]);
contourf(X1, X2, fn, 30, 'LineColor', 'none');
hold on;
plot(0.46557, 2.1479, 'r*', 'MarkerSize', 12, 'LineWidth', 2, 'DisplayName', 'Global min');
plot(-1,      -0.5,   'bs', 'MarkerSize',  9, 'LineWidth', 2, 'DisplayName', 'Local min');
plot(-1/3,    -7/54,  'g^', 'MarkerSize',  9, 'LineWidth', 2, 'DisplayName', 'Saddle');
hold off;
colorbar;
xlabel('x_1'); ylabel('x_2');
legend('Location', 'northwest');

[~,~] = mkdir('images');
print(fig, 'images/Contour_Problem1', '-dpng', '-r150');
close(fig);
