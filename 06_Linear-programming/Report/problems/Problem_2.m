% Per 100g: cheese has 20g protein, 20g carbs; bread has 10g protein, 30g carbs.
% Variables x1, x2 are quantities in kg (1 kg = 10 * 100g).
% Per-kg nutrition: cheese 200g protein, 200g carbs; bread 100g protein, 300g carbs.
%
% min  30*x1 + 20*x2           (cost in PLN)
% s.t. 200*x1 + 100*x2 >= 60  (protein >= 60g)
%      200*x1 + 300*x2 >= 120 (carbs  >= 120g)
%      x1, x2 >= 0
%
% Standard form with surplus variables s1, s2 >= 0:
%   200*x1 + 100*x2 - s1 = 60
%   200*x1 + 300*x2 - s2 = 120
% No initial BFS -> two-phase simplex with artificial variables.

A = [200, 100, -1,  0;
     200, 300,  0, -1];
b = [60; 120];
f = [30, 20, 0, 0];

[tab, x_sol] = twoPhaseSimplexMethod(A, b, f);

fprintf('\nOptimal diet:\n');
fprintf('Cheese: %.2f kg\n', x_sol(1));
fprintf('Bread:  %.2f kg\n', x_sol(2));
fprintf('Minimum daily cost: %.2f PLN\n', -tab(end,end));
fprintf('Protein intake: %.1f g\n', 200*x_sol(1) + 100*x_sol(2));
fprintf('Carbohydrate intake: %.1f g\n', 200*x_sol(1) + 300*x_sol(2));

% Optimal diet:
% Cheese: 0.15 kg
% Bread:  0.30 kg
% Minimum daily cost: 10.50 PLN
% Protein intake: 60.0 g
% Carbohydrate intake: 120.0 g
