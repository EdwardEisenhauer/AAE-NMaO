% Satellite constellation argument-of-latitude optimiser.
%
% Finds the minimum-fuel orbital transfers that equally space 6 satellites,
% while optionally balancing remaining fuel levels across the constellation.
%
% Requires: Optimization Toolbox, Aerospace Toolbox (wrapTo2Pi)

%% --- Inputs --------------------------------------------------------------

u = deg2rad([40; 105; 170; 245; 305; 350]);  % current arguments of latitude [rad]
f = [100; 95; 102; 98; 100; 97];             % current fuel levels [units]

plot_constellation(u)

% Strategy: 'weighted' (single solve) or 'lexicographic' (two solves)
STRATEGY = 'weighted';

% Weights for 'weighted' strategy (ignored by 'lexicographic')
W1 = 1;  % total fuel consumed
W2 = 1;  % max fuel imbalance after manoeuvre

%% --- Optimise ------------------------------------------------------------

[delta, u_target, remaining_fuel, fuel_consumed, fuel_imbalance] = ...
    optimize_satellite_constellation(u, f, STRATEGY, W1, W2);

%% --- Results -------------------------------------------------------------

N = numel(u);

fprintf('\nStrategy: %s\n', STRATEGY);
fprintf('%-10s %-12s %-14s %-12s %-14s %-14s\n', ...
    'Satellite', 'u now [deg]', 'u target [deg]', 'delta [deg]', 'Direction', 'Remaining fuel');
for i = 1:N
    d = rad2deg(delta(i));
    if     d >  0.01, dir = 'prograde';
    elseif d < -0.01, dir = 'retrograde';
    else,             dir = 'none';
    end
    fprintf('%-10d %-12.2f %-14.2f %-12.2f %-14s %.2f\n', ...
        i, rad2deg(wrapTo2Pi(u(i))), rad2deg(u_target(i)), d, dir, remaining_fuel(i));
end
fprintf('\nTotal fuel consumed: %.4f\n', fuel_consumed);
fprintf('Max fuel imbalance:  %.4f\n',  fuel_imbalance);

plot_constellation(u + delta)
