%% Problem 1 — contour plot of f(x) = 0.5*||F(x)||^2

x1g = linspace(-2, 1.5, 600);
x2g = linspace(-1.5, 3.5, 600);
[X1, X2] = meshgrid(x1g, x2g);

F1 = X1.^3 + 3*X1.^2 + 3*X1 - X2;
F2 = X1.^2 + 2*X1   - X2 + 1;
f  = (F1.^2 + F2.^2) / 2;

pts     = [0.46557,  2.1479;
           -1,      -0.5;
           -1/3,    -7/54];
markers = {'r*', 'bs', 'g^'};
msizes  = [14, 10, 10];
lbls    = {'Global min $\mathbf{x}^*$', ...
           'Local min $\mathbf{x}^{(1)}$', ...
           'Saddle $\mathbf{x}^{(2)}$'};

figure('Color', 'w', 'Units', 'inches', 'Position', [0 0 6 4.5]);
contourf(X1, X2, min(f, 2), 50, 'LineColor', 'none');
colormap(flipud(hot));
cb = colorbar;
cb.Label.String = 'f(\bf{x})';
caxis([0, 2]);
hold on;

for k = 1:size(pts, 1)
    plot(pts(k,1), pts(k,2), markers{k}, ...
        'MarkerSize', msizes(k), 'LineWidth', 2);
end

legend(lbls{:}, 'Interpreter', 'latex', 'Location', 'northwest', 'FontSize', 9);
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$x_2$', 'Interpreter', 'latex');
axis tight;

mkdir('../Report/images');
print(gcf, '../Report/images/Contour_Problem1', '-dpng', '-r150');
