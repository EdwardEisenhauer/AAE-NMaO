%% Problem 1
% Find the solution that best

%
% 3 * x_1 - x_2 = 4
% x_1 + 2 * x_2 = 0
% 2 * x_1 + x_2 = 1
%

A = [3, -1]

b = [ 4;
      0;
      1]

x = A' * inv(A*A') * b

%% Problem 2

points_a = [ 0,  3;
           1,  0;
           1, -1;
          -1,  2]

points_b = [ -1, 0.5;
           0,  1;
           2, 5;
          3,  9]

syms a_0 a_1 a_2

f = @(x) a_0 + a_1*x^2 + a_2 * sin(pi*x/2)

solve(f(points_a(1, 1)) == points_a(1, 2), a_0, a_1, a_2)


% y(t) = alpha + beta*t

first_matrix = [
    1, 0;
    1, 1;
    1, 1;
    1, -1
]

second_matrix = [
    
]