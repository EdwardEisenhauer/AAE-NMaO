% Satellite constellation argument-of-latitude optimiser.
%
% Finds the minimum-delta-v orbital transfers that equally space 6 satellites,
% while optionally balancing remaining delta-v budgets across the constellation.
%

%% --- Inputs --------------------------------------------------------------

u  = deg2rad([40; 105; 170; 245; 305; 350]);  % current arguments of latitude [rad]
f  = [1102; 1230; 870; 900; 960; 979];            % delta-v budget per satellite [m/s]
h  = 550;                                     % orbital altitude [km]
mu = 3.986004418e14;                          % Earth gravitational parameter [m^3/s^2]

FIG_DIR = fullfile(fileparts(mfilename('fullpath')), 'figures');
if ~exist(FIG_DIR, 'dir'), mkdir(FIG_DIR); end

plot_constellation(u, 'Initial constellation');
exportgraphics(gcf, fullfile(FIG_DIR, 'constellation_initial.pdf'), 'ContentType', 'vector');

% Strategy: 'weighted' (single solve) or 'lexicographic' (two solves)
% STRATEGY = 'weighted';
STRATEGY = 'lexicographic';

% Weights for 'weighted' strategy (ignored by 'lexicographic')
W1 = 1;  % total fuel consumed
W2 = 1;  % max fuel imbalance after manoeuvre

%% --- Optimise ------------------------------------------------------------

[delta, u_target, remaining_fuel, fuel_consumed, fuel_imbalance, dv_per_sat] = ...
    optimize_satellite_constellation(u, f, h, mu, STRATEGY, W1, W2);

%% --- Results -------------------------------------------------------------

N = numel(u);

fprintf('\nStrategy: %s\n', STRATEGY);
fprintf('%-10s %-12s %-14s %-12s %-11s %-14s %-14s\n', ...
    'Satellite', 'u now [deg]', 'u target [deg]', 'delta [deg]', 'dv [m/s]', 'First burn', 'Remaining [m/s]');
for i = 1:N
    d = rad2deg(delta(i));
    if     d >  0.01, burn = 'retrograde';   % lower phasing orbit
    elseif d < -0.01, burn = 'prograde';     % higher phasing orbit
    else,             burn = 'none';
    end
    fprintf('%-10d %-12.2f %-14.2f %-12.2f %-11.4f %-14s %.2f\n', ...
        i, rad2deg(mod(u(i), 2*pi)), rad2deg(u_target(i)), d, dv_per_sat(i), burn, remaining_fuel(i));
end
fprintf('\nTotal delta-v consumed: %.4f m/s\n', fuel_consumed);
fprintf('Max delta-v imbalance:  %.4f m/s\n',   fuel_imbalance);

plot_manoeuvre_plan(u, delta, 'Manoeuvre plan (red: retrograde, green: prograde)');
exportgraphics(gcf, fullfile(FIG_DIR, 'constellation_manoeuvre.pdf'), 'ContentType', 'vector');

plot_constellation(u_target, 'Target constellation');
exportgraphics(gcf, fullfile(FIG_DIR, 'constellation_target.pdf'), 'ContentType', 'vector');
