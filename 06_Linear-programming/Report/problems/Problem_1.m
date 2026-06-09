f = [-1 -1]; % minimize -x1-x2 to maximize x1+x2
A = [ 1, 2;
      4, 2;
     -1, 1];
b = [4; 12; 1];
[tableau, x_sol] = simplex(f, A, b);
fprintf('Optimal solution:\n');
fprintf('x1 = %.4f\nx2 = %.4f\n', x_sol(1), x_sol(2));
fprintf('Optimal value (x1+x2): %.4f\n', tableau(end,end));

% Optimal solution:
% x1 = 2.6667
% x2 = 0.6667
% Optimal value (x1+x2): 3.3333
