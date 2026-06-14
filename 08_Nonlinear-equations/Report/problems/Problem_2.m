%% Symbolic stationarity analysis
syms x1 x2

F1 = x1^3 + 3*x1^2 + 3*x1 - x2 - 3;
F2 = x1^2  + 2*x1  - x2;
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
    M1 = Hk(1,1);  dH = det(Hk);
    fprintf('x = (%.5f, %.5f),  f = %.6f,  M1 = %.4f,  det = %.4f\n', ...
        a1(k), a2(k), fval, M1, dH);
    if     dH > 0 && M1 > 0 && abs(fval) < 1e-8, disp('  => Global minimum');
    elseif dH > 0 && M1 > 0,                      disp('  => Spurious local minimum');
    elseif dH < 0,                                 disp('  => Saddle point');
    end
end

%% Numerical functions
Fn = @(x) [x(1)^3 + 3*x(1)^2 + 3*x(1) - x(2) - 3;
            x(1)^2 + 2*x(1) - x(2)];
Jn = @(x) [3*x(1)^2 + 6*x(1) + 3, -1;
            2*x(1) + 2,             -1];

tol = 1e-10;  maxiter = 200;
starts = {[2; 5], [-1.5; -2]};

%% Gauss-Newton
paths_gn = cell(size(starts));
for s = 1:numel(starts)
    x = starts{s};  path = x.';
    for k = 1:maxiter
        Fk = Fn(x);  Jk = Jn(x);
        JtJ = Jk.' * Jk;
        if rcond(JtJ) < 1e-14, break; end
        p = -JtJ \ (Jk.' * Fk);
        x = x + p;  path(end+1,:) = x.'; %#ok<AGROW>
        if norm(p) < tol, break; end
    end
    paths_gn{s} = path;
    fprintf('GN  start=(% .1f,% .1f): x=(%.6f, %.6f), f=%.2e, iter=%d\n', ...
        starts{s}(1), starts{s}(2), x(1), x(2), 0.5*norm(Fn(x))^2, size(path,1)-1);
end

%% Levenberg-Marquardt (adaptive lambda)
paths_lm = cell(size(starts));
for s = 1:numel(starts)
    x = starts{s};  lam = 1;  path = x.';
    for k = 1:maxiter
        Fk  = Fn(x);  Jk = Jn(x);
        p   = -(Jk.'*Jk + lam*eye(2)) \ (Jk.'*Fk);
        if 0.5*norm(Fn(x+p))^2 < 0.5*norm(Fk)^2
            x = x + p;  lam = max(lam/10, 1e-12);
        else
            lam = min(lam*10, 1e8);
        end
        path(end+1,:) = x.'; %#ok<AGROW>
        if norm(p) < tol, break; end
    end
    paths_lm{s} = path;
    fprintf('LM  start=(% .1f,% .1f): x=(%.6f, %.6f), f=%.2e, iter=%d\n', ...
        starts{s}(1), starts{s}(2), x(1), x(2), 0.5*norm(Fn(x))^2, size(path,1)-1);
end

%% Contour plot with iteration paths
x1v = linspace(-3, 3.5, 600);
x2v = linspace(-5, 8, 600);
[X1, X2] = meshgrid(x1v, x2v);
fn = 0.5*((X1.^3 + 3*X1.^2 + 3*X1 - X2 - 3).^2 + (X1.^2 + 2*X1 - X2).^2);
fn = min(fn, 5);

fig = figure('Visible', 'off', 'Units', 'centimeters', 'Position', [0 0 18 14]);
contourf(X1, X2, fn, 40, 'LineColor', 'none');
colormap(flipud(hot));
cb = colorbar;  cb.Label.String = 'f(\bf{x})';
caxis([0, 5]);
hold on;

clrs = {'b', 'c'};
for s = 1:numel(starts)
    pg = paths_gn{s};
    pl = paths_lm{s};
    plot(pg(:,1), pg(:,2), '-o', 'Color', clrs{s}, 'MarkerSize', 3, ...
        'LineWidth', 1.2, 'DisplayName', ...
        sprintf('GN (%.0f,%.0f)', starts{s}(1), starts{s}(2)));
    plot(pl(:,1), pl(:,2), '--s', 'Color', clrs{s}, 'MarkerSize', 3, ...
        'LineWidth', 1.2, 'DisplayName', ...
        sprintf('LM (%.0f,%.0f)', starts{s}(1), starts{s}(2)));
end

% Stationary points
spts   = [double(a1(imag(a1)==0)), double(a2(imag(a2)==0))];
spts   = spts(imag(spts(:,1))==0 & imag(spts(:,2))==0, :);
mks    = {'r*', 'bs', 'g^'};
lbls   = {'Global min $\mathbf{x}^*$', 'Local min $\mathbf{x}^{(1)}$', 'Saddle $\mathbf{x}^{(2)}$'};
fvals  = arrayfun(@(k) double(subs(f,{x1,x2},{spts(k,1),spts(k,2)})), 1:size(spts,1));
[~, ord] = sort(fvals);
for k = 1:min(3, size(spts,1))
    idx = ord(k);
    plot(spts(idx,1), spts(idx,2), mks{k}, 'MarkerSize', 10, 'LineWidth', 2, ...
        'DisplayName', lbls{k});
end

hold off;
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$x_2$', 'Interpreter', 'latex');
legend('Location', 'northwest', 'Interpreter', 'latex', 'FontSize', 8);

[~,~] = mkdir('images');
print(fig, 'images/Contour_Problem2', '-dpng', '-r150');
close(fig);
