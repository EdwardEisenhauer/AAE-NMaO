%% Problem 1 - Maximise x1+x2 subject to three inequality constraints
% max x1 + x2
% s.t.  x1 + 2x2 <= 4
%       4x1 + 2x2 <= 12
%      -x1 +  x2 <= 1
%       x1, x2 >= 0
%
% The simplex implementation minimises, so we pass f = -[1,1].
% All constraints are of the <= form with non-negative RHS, so
% slack variables give an immediate initial basic feasible solution.

clear; clc;
addpath('../Report/algorithms');

f1 = [-1, -1];
A1 = [ 1, 2;
       4, 2;
      -1, 1];
b1 = [4; 12; 1];

[tab1, x1_sol] = simplex(f1, A1, b1);

fprintf('=== Problem 1 ===\n');
fprintf('x1 = %.4f,  x2 = %.4f\n', x1_sol(1), x1_sol(2));
fprintf('Optimal value (x1 + x2) = %.4f\n\n', tab1(end,end));

% Verify with MATLAB built-in (linprog minimises by default)
[x1_lp, fval1] = linprog(f1, A1, b1, [], [], zeros(2,1));
fprintf('linprog check: x1=%.4f  x2=%.4f  fval=%.4f\n\n', ...
    x1_lp(1), x1_lp(2), -fval1);

%% Problem 2 - Minimum-cost diet with nutritional lower bounds
% min  30*x1 + 20*x2                    (cost in PLN)
% s.t. 200*x1 + 100*x2 >= 60  (protein >= 60 g)
%      200*x1 + 300*x2 >= 120 (carbs   >= 120 g)
%      x1, x2 >= 0
%
% Constraints are >= so we cannot use the plain simplex directly.
% Standard form: subtract surplus variables, add artificials -> two-phase.

A2 = [200, 100, -1,  0;
      200, 300,  0, -1];
b2 = [60; 120];
f2 = [30, 20, 0, 0];

[tab2, x2_sol] = twoPhaseSimplexMethod(A2, b2, f2);

fprintf('=== Problem 2 ===\n');
fprintf('Cheese:  %.2f kg\n', x2_sol(1));
fprintf('Bread:   %.2f kg\n', x2_sol(2));
fprintf('Cost:    %.2f PLN\n', -tab2(end,end));
fprintf('Protein: %.1f g  (min 60 g)\n', 200*x2_sol(1) + 100*x2_sol(2));
fprintf('Carbs:   %.1f g  (min 120 g)\n\n', 200*x2_sol(1) + 300*x2_sol(2));

% Verify with linprog
f2_lp  = [30; 20];
A2_lp  = [-200, -100;   % flip >= to <=
          -200, -300];
b2_lp  = [-60; -120];
[x2_lp, fval2] = linprog(f2_lp, A2_lp, b2_lp, [], [], zeros(2,1));
fprintf('linprog check: cheese=%.2f kg  bread=%.2f kg  cost=%.2f PLN\n', ...
    x2_lp(1), x2_lp(2), fval2);
