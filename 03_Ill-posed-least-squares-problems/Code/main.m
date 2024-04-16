%% Problem 1
%
% 3x_1 -  x_2 = 4
%  x_1 + 2x_2 = 0
% 2x_1 +  x_2 = 1
A = [3, -1;
     1,  2;
     2,  1];
b = [4;
     0;
     1];
x = normal_approximation(A, b)
solution_error = x - A\b
%
% 3x_1 +  x_2 +  x_3 = 6
% 2x_1 + 3x_2 -  x_3 = 1
% 2x_1 -  x_2 +  x_3 = 0
% 3x_1 - 3x_2 + 3x_3 = 8
A = [3,  1,  1;
     2,  3, -1;
     2, -1,  1;
     3, -3,  3];
b = [6;
     1;
     0;
     8];
x = normal_approximation(A, b)
solution_error = x - A\b
%
%  x_1 +  x_2 -  x_3 = 5
% 2x_1 -  x_2 + 6x_3 = 1
% -x_1 + 4x_2 +  x_3 = 0
% 3x_1 + 2x_2 -  x_3 = 6
A = [ 1,  1, -1;
      2, -1,  6;
     -1,  4,  1;
      3,  2, -1];
b = [5;
     1;
     0;
     6];
x = normal_approximation(A, b)
solution_error = x - A\b
%% Problem 2
%h
% Find the least squares approximating a_0 + a_1 * x^2 + a_2 * sin(pi*x/2)
%  for each of the following sets of data pairs:
%
% (0,3),(1,0),(1,-1),(-1,2)
%
% a_0 + a_1 *  0^2 + a_2 * sin(pi*0/2)  =  3
% a_0 + a_1 *  1^2 + a_2 * sin(pi*1/2)  =  0
% a_0 + a_1 *  1^2 + a_2 * sin(pi*1/2)  = -1
% a_0 + a_1 * -1^2 + a_2 * sin(pi*-1/2) =  2
disp("PROBLEM 2")
A = [1, 0, 0;
     1, 1, sin(pi/2);
     1, 1, sin(pi/2);
     1, 1, sin(-pi/2)];
b = [ 3;
      0;
     -1;
      2];
a = normal_approximation(A, b)
solution_error = a - A\b

f = @(x, a) a(1) + a(2) * x.^2 + a(3) * sin(pi.*x/2);

pairs = [0, 3; 1, 0; 1, -1; -1, 2];
x_fun = -2:0.1:2;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
legend("Data pairs", ...
    "y = " + a(1) + " + " + a(2) + " * x^2 + " + a(3) + " * sin(pi*x/2)")
return
% (-1,0.5),(0,1),(2,5),(3,9)
%
% a_0 + a_1 * -1^2 + a_2 * sin(pi*-1/2) = 0.5
% a_0 + a_1 *  0^2 + a_2 * sin(pi*0/2)  = 1
% a_0 + a_1 *  2^2 + a_2 * sin(pi*2/2)  = 5
% a_0 + a_1 *  3^2 + a_2 * sin(pi*3/2)  = 9
%
A = [ 1,  1, sin(-pi/2);
      1,  0, sin(0);
      1,  4, sin(pi);
      1,  9, sin(pi*3/2)];
b = [ 0.5;
      1;
      5;
      9];
a = normal_approximation(A, b)
solution_error = a - A\b
return
%% Problem 3
%
% y = a_0 + a_1 * x_1 + a_2 * x_2 + a_3 * x_3
A = [ 1, 50, 18, 10;
      1, 40, 20, 16;
      1, 35, 14, 10;
      1, 40, 12, 12;
      1, 30, 16, 14];
b = [ 28;
      30;
      21;
      23;
      23];
a = normal_approximation(A, b)
%% Problem 4
A = [1, 1;
     1, 2;
     1, 3;
     1, 4;
     1, 5;
     1, 6;
     1, 7;
     1, 8];
b = [1.5;
     2.0;
     2.8;
     4.1;
     4.9;
     6.3;
     5.0;
    11.5];
a = normal_approximation(A, b)
% [a, b] = least_squares_approximation(x, y)

%% Problem 5
%
% y = a_2 * x^2 + a_1 * x + a_0
disp("PROBLEM 5")
A = [  0^2,    0, 1;
     250^2,  250, 1;
     500^2,  500, 1;
     750^2,  750, 1;
     1000^2, 1000, 1];
b = [0;
     8;
    15;
    19;
    20];
a = normal_approximation(A, b)
a_2 = a(1)
a_1 = a(2)
a_0 = a(3)

determinant = a_1^2-4*a_2*a_0
x_1 = (-a_1-sqrt(determinant)) / (2*a_2)
x_2 = (-a_1+sqrt(determinant)) / (2*a_2)
%% Problem 6
%
disp("PROBLEM 6")
% y = a_0 + a_1 * x
A = [ 1,  -5;
      1,  -4;
      1,  -3;
      1,  -2;
      1,  -1];
b = [2;
     7;
     9;
    12;
    13];
a = normal_approximation(A, b);
a_0 = a(1)
a_1 = a(2)
% y = a_0 + a_1 * x + a_2 * x^2
A = [ 1,  -5, 25;
      1,  -4, 16;
      1,  -3,  9;
      1,  -2,  4;
      1,  -1,  1;
      1,   0,  1;
      1,   1,  1;
      1,   2,  4;
      1,   3,  9;
      1,   4, 16;
      1,   5, 25];
b = [2;
     7;
     9;
    12;
    13;
    14;
    14;
    13;
    10;
     8;
     4];
a = normal_approximation(A, b);
a_0 = a(1)
a_1 = a(2)
a_2 = a(3)

y = a_0 + a_1 * x + a_2 * x.^2
%% Problem 7

%% Functions
function x = normal_approximation(A, b)
% NORMAL_APPROXIMATION
%   x = normal_approximation(A, b) returns the approximate least-squares
%     solution to the inconsistent system of linear equations Ax = b.
%
%   Arguments:
%     A --- Coefficient matrix.
%     b --- Column vector of constant terms.

x = inv(A' * A) * A' * b;

end

function [a, b] = least_squares_approximation(x, y)

N = size(x, 1);

a = N .* sum(x.*y) - sum(x) .* sum(y) / ( N .* sum(x.^2) - sum(x).^2);

b = sum(y) - a * sum(x) / N;

end
