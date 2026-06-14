function [delta, u_target, remaining_fuel, fuel_consumed, fuel_imbalance, dv_per_sat] = ...
        optimize_satellite_constellation(u, f, h, mu, strategy, W1, W2)
% Finds minimum-delta-v orbital transfers that equally space a satellite constellation.
%
%   u               (N,1) current arguments of latitude [rad]
%   f               (N,1) current delta-v budget per satellite [m/s]
%   h               orbital altitude [km]            (default: 550 km, SSO)
%   mu              gravitational parameter [m^3/s^2] (default: Earth)
%   strategy        'weighted' (default) or 'lexicographic'
%   W1              weight on total delta-v consumed   (weighted only, default 1)
%   W2              weight on max delta-v imbalance    (weighted only, default 1)
%
%   delta           (N,1) angular transfer per satellite [rad]
%   u_target        (N,1) target argument of latitude [rad]
%   remaining_fuel  (N,1) remaining delta-v budget after manoeuvre [m/s]
%   fuel_consumed   total delta-v consumed across constellation [m/s]
%   fuel_imbalance  max deviation of remaining budgets from their mean [m/s]
%   dv_per_sat      (N,1) delta-v consumed per satellite [m/s]

arguments
    u        (:,1) double
    f        (:,1) double
    h        double = 550                    % orbital altitude [km]
    mu       double = 3.986004418e14         % Earth gravitational parameter [m^3/s^2]
    strategy char   = 'weighted'
    W1       double = 1
    W2       double = 1
end

R_EARTH = 6371;                              % mean Earth radius [km]
r       = (R_EARTH + h) * 1e3;              % orbital radius [m]

N       = numel(u);
spacing = 2*pi / N;

[u_sorted, sort_idx] = sort(mod(u, 2*pi));
f_sorted       = f(sort_idx);
target_offsets = (0:N-1)' * spacing;

% With N equally-spaced targets, the spacing constraint fixes all delta_i
% given a single free variable u_ref. Wrapping to [-pi, pi] selects the
% shortest-path transfer for each satellite.
delta_fn  = @(u_ref) mod(u_ref + target_offsets - u_sorted + pi, 2*pi) - pi;
dv_fn     = @(u_ref) dv_phasing(delta_fn(u_ref), r, mu);
total_dv  = @(u_ref) sum(dv_fn(u_ref));
imbalance = @(u_ref) max(abs((f_sorted - dv_fn(u_ref)) - mean(f_sorted - dv_fn(u_ref))));

switch strategy
    case 'weighted'
        obj       = @(u_ref) W1 * total_dv(u_ref) + W2 * imbalance(u_ref);
        u_ref_opt = fminbnd(obj, 0, 2*pi);

    case 'lexicographic'
        % TODO: fminbnd may miss a global minimum if the objective is not
        %       unimodal. A multi-start sweep over u_ref would be more robust.
        % Stage 1: minimise total delta-v
        u_ref_opt = fminbnd(total_dv, 0, 2*pi);
        dv_min    = total_dv(u_ref_opt);
        % Stage 2: minimise imbalance subject to total delta-v <= dv_min + tol
        obj2      = @(u_ref) imbalance(u_ref) + ...
                    1e6 * max(0, total_dv(u_ref) - dv_min * (1 + 1e-6));
        u_ref_opt = fminbnd(obj2, 0, 2*pi);

    otherwise
        error('optimize_satellite_constellation:unknownStrategy', ...
            'Unknown strategy "%s". Use ''weighted'' or ''lexicographic''.', strategy);
end

delta_sol = delta_fn(u_ref_opt);
dv_sol    = dv_fn(u_ref_opt);

% TODO: add feasibility check — warn (or error) when dv_sol(i) > f_sorted(i),
%       which produces negative remaining_fuel and an infeasible manoeuvre plan.

delta(sort_idx, 1)          = delta_sol;
u_target(sort_idx, 1)       = mod(u_sorted + delta_sol, 2*pi);
dv_per_sat(sort_idx, 1)     = dv_sol;
remaining_fuel(sort_idx, 1) = f_sorted - dv_sol;

fuel_consumed  = sum(dv_sol);
fuel_imbalance = imbalance(u_ref_opt);

end

function total_dv = dv_phasing(delta, r, mu)
% Total delta-v (two burns) for a one-revolution phasing manoeuvre.
% Positive delta: retrograde burn into lower orbit (gains angle).
% Negative delta: prograde burn into higher orbit (loses angle).
%
% TODO: generalise to k-revolution phasing — replace (2*pi) with (2*pi*k)
%       and expose k as a parameter. This reduces dv by roughly 1/k at the
%       cost of a longer transfer time, which may be preferable when
%       the required angular correction exceeds the one-revolution budget.
a_ph     = r ./ (1 + delta ./ (2*pi)).^(2/3);
v_c      = sqrt(mu / r);
v_ph     = sqrt(mu .* (2./r - 1./a_ph));
total_dv = 2 * abs(v_ph - v_c);
end
