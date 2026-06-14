% Satellite constellation argument-of-latitude optimiser.
%
% Runs two strategies side-by-side and saves figures for the presentation.

%% --- Inputs --------------------------------------------------------------

u  = deg2rad([40; 105; 170; 245; 305; 350]);  % current arguments of latitude [rad]
f  = [1102; 1230; 870; 900; 960; 979];        % delta-v budget per satellite [m/s]
h  = 550;                                     % orbital altitude [km]
mu = 3.986004418e14;                          % Earth gravitational parameter [m^3/s^2]

N = numel(u);

FIG_DIR = fullfile(fileparts(mfilename('fullpath')), 'figures');
if ~exist(FIG_DIR, 'dir'), mkdir(FIG_DIR); end

%% --- Initial plot --------------------------------------------------------

plot_constellation(u, 'Initial constellation');
exportgraphics(gcf, fullfile(FIG_DIR, 'constellation_initial.pdf'), 'ContentType', 'vector');

%% --- Strategy A: Weighted (W1=1, W2=10 — strong balance emphasis) --------

W1 = 1; W2 = 10;
[delta_W, u_target_W, rem_W, consumed_W, imbalance_W, dv_W] = ...
    optimize_satellite_constellation(u, f, h, mu, 'weighted', W1, W2);

%% --- Strategy B: Lexicographic -------------------------------------------

[delta_L, u_target_L, rem_L, consumed_L, imbalance_L, dv_L] = ...
    optimize_satellite_constellation(u, f, h, mu, 'lexicographic');

%% --- Print and save results ----------------------------------------------

strategies   = {'weighted (W1=1, W2=10)', 'lexicographic'};
deltas       = {delta_W,    delta_L};
u_targets    = {u_target_W, u_target_L};
dv_per_sats  = {dv_W,       dv_L};
rem_fuels    = {rem_W,      rem_L};
consumeds    = {consumed_W, consumed_L};
imbalances   = {imbalance_W, imbalance_L};
out_files    = {'out_weighted.m', 'out_lexicographic.m'};

for s = 1:2
    fid = fopen(out_files{s}, 'w');
    for fids = [1, fid]
        fprintf(fids, 'Strategy: %s\n', strategies{s});
        fprintf(fids, '%-10s %-12s %-14s %-12s %-11s %-14s %-14s\n', ...
            'Satellite', 'u now [deg]', 'u target [deg]', 'delta [deg]', ...
            'dv [m/s]', 'First burn', 'Remaining [m/s]');
        for i = 1:N
            d = rad2deg(deltas{s}(i));
            if     d >  0.01, burn = 'retrograde';
            elseif d < -0.01, burn = 'prograde';
            else,             burn = 'none';
            end
            fprintf(fids, '%-10d %-12.2f %-14.2f %-12.2f %-11.4f %-14s %.2f\n', ...
                i, rad2deg(mod(u(i), 2*pi)), rad2deg(u_targets{s}(i)), ...
                d, dv_per_sats{s}(i), burn, rem_fuels{s}(i));
        end
        fprintf(fids, '\nTotal delta-v consumed: %.4f m/s\n', consumeds{s});
        fprintf(fids, 'Max delta-v imbalance:  %.4f m/s\n\n', imbalances{s});
    end
    fclose(fid);
end

%% --- Comparison bar chart ------------------------------------------------

figure;
bar(1:N, [rem_W, rem_L]);
xlabel('Satellite');
ylabel('\Deltav remaining [m/s]');
title('Remaining fuel after manoeuvres');
legend('Weighted (W_1=1, W_2=10)', 'Lexicographic', 'Location', 'southwest');
grid on;
exportgraphics(gcf, fullfile(FIG_DIR, 'comparison.pdf'), 'ContentType', 'vector');

%% --- Manoeuvre plan plots ------------------------------------------------

plot_manoeuvre_plan(u, delta_W, 'Manoeuvre plan — weighted (W_1=1, W_2=10)');
exportgraphics(gcf, fullfile(FIG_DIR, 'manoeuvre_weighted.pdf'), 'ContentType', 'vector');

plot_manoeuvre_plan(u, delta_L, 'Manoeuvre plan — lexicographic');
exportgraphics(gcf, fullfile(FIG_DIR, 'manoeuvre_lexicographic.pdf'), 'ContentType', 'vector');

%% --- Target constellation (lexicographic) --------------------------------

plot_constellation(u_target_L, 'Target constellation');
exportgraphics(gcf, fullfile(FIG_DIR, 'constellation_target.pdf'), 'ContentType', 'vector');
