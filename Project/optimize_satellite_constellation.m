function [delta, u_target, remaining_fuel, fuel_consumed, fuel_imbalance] = ...
        optimize_satellite_constellation(u, f, strategy, W1, W2)
% Finds minimum-fuel orbital transfers that equally space a satellite constellation.
%
%   u               (N,1) current arguments of latitude [rad]
%   f               (N,1) current fuel levels [units]
%   strategy        'weighted' (default) or 'lexicographic'
%   W1              weight on total fuel consumed (weighted strategy only, default 1)
%   W2              weight on max fuel imbalance  (weighted strategy only, default 1)
%
%   delta           (N,1) required transfer per satellite [rad]
%   u_target        (N,1) target argument of latitude per satellite [rad]
%   remaining_fuel  (N,1) fuel level after manoeuvre
%   fuel_consumed   total fuel consumed (sum of |delta|)
%   fuel_imbalance  max deviation of remaining fuel from its mean

arguments
    u        (:,1) double
    f        (:,1) double
    strategy  char   = 'weighted'
    W1        double = 1
    W2        double = 1
end

N       = numel(u);
spacing = 2*pi / N;

[u_sorted, sort_idx] = sort(wrapTo2Pi(u));
f_sorted = f(sort_idx);

target_offsets = (0:N-1)' * spacing;

% LP variables
prob  = optimproblem('ObjectiveSense', 'minimize');
delta_var = optimvar('delta', N, 'LowerBound', -pi,  'UpperBound', pi);
u_ref     = optimvar('u_ref', 1, 'LowerBound',  0,   'UpperBound', 2*pi);
s         = optimvar('s',     N, 'LowerBound',  0);
t         = optimvar('t',     1, 'LowerBound',  0);

% Equal spacing
prob.Constraints.spacing = u_sorted + delta_var == u_ref + target_offsets;

% Absolute value linearisation
prob.Constraints.abs_pos = s >= delta_var;
prob.Constraints.abs_neg = s >= -delta_var;

% Fuel balance constraints
remaining      = f_sorted - s;
mean_remaining = sum(remaining) / N;
for i = 1:N
    prob.Constraints.(sprintf('bal_pos_%d', i)) = remaining(i) - mean_remaining <= t;
    prob.Constraints.(sprintf('bal_neg_%d', i)) = mean_remaining - remaining(i) <= t;
end

switch strategy
    case 'weighted'
        prob.Objective = W1 * sum(s) + W2 * t;
        sol = solve(prob);

    case 'lexicographic'
        % Stage 1: minimise total fuel, no balance constraints
        prob.Objective = sum(s);
        for i = 1:N
            prob.Constraints.(sprintf('bal_pos_%d', i)) = optimconstr(0);
            prob.Constraints.(sprintf('bal_neg_%d', i)) = optimconstr(0);
        end
        sol1     = solve(prob);
        fuel_opt = sum(evaluate(s, sol1));

        % Stage 2: fix total fuel, minimise imbalance
        prob.Constraints.fuel_cap = sum(s) == fuel_opt;
        for i = 1:N
            prob.Constraints.(sprintf('bal_pos_%d', i)) = remaining(i) - mean_remaining <= t;
            prob.Constraints.(sprintf('bal_neg_%d', i)) = mean_remaining - remaining(i) <= t;
        end
        prob.Objective = t;
        sol = solve(prob);

    otherwise
        error('optimize_satellite_constellation:unknownStrategy', ...
            'Unknown strategy "%s". Use ''weighted'' or ''lexicographic''.', strategy);
end

% Unpack and map back to original satellite order
delta_sol = evaluate(delta_var, sol);
s_sol     = evaluate(s, sol);

delta          = zeros(N, 1);
delta(sort_idx) = delta_sol;

u_target_sorted          = wrapTo2Pi(u_sorted + delta_sol);
u_target                 = zeros(N, 1);
u_target(sort_idx)       = u_target_sorted;

remaining_sorted         = f_sorted - s_sol;
remaining_fuel           = zeros(N, 1);
remaining_fuel(sort_idx) = remaining_sorted;

fuel_consumed  = sum(s_sol);
fuel_imbalance = evaluate(t, sol);

end
