function plot_constellation(u)
% Plots satellite positions on a circular orbit in the orbital plane.
%
%   u   vector of arguments of latitude [rad]

N     = numel(u);
theta = linspace(0, 2*pi, 500);

figure;
hold on;
axis equal off;

% Orbit
plot(cos(theta), sin(theta), 'Color', [0.6 0.6 0.6], 'LineWidth', 1.5);

% Central body
fill(0.07*cos(theta), 0.07*sin(theta), [0.2 0.4 0.8], 'EdgeColor', 'none');

% Ascending node direction
plot([0 1.12], [0 0], '--', 'Color', [0.5 0.5 0.5], 'LineWidth', 0.8);
text(1.15, 0, '\Omega', 'HorizontalAlignment', 'left', 'FontSize', 10, 'Color', [0.4 0.4 0.4]);

% Satellites
colors = lines(N);
r_label = 1.22;
for i = 1:N
    angle = wrapTo2Pi(u(i));
    x = cos(angle);
    y = sin(angle);
    plot(x, y, 'o', ...
        'MarkerSize',      10, ...
        'MarkerFaceColor', colors(i, :), ...
        'MarkerEdgeColor', 'k', ...
        'LineWidth',       1);
    text(r_label * cos(angle), r_label * sin(angle), ...
        sprintf('S_{%d}  %.1f°', i, rad2deg(angle)), ...
        'HorizontalAlignment', 'center', ...
        'FontSize',            9);
end

title('Satellite Constellation');
end
