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
implementation_error = x - A\b
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
implementation_error = x - A\b
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
implementation_error = x - A\b
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
    "f(x) = " + a(1) + " + " + a(2) + " * x^2 + " + a(3) + " * sin(pi*x/2)")
% (-1,0.5),(0,1),(2,5),(3,9)
%
% a_0 + a_1 * -1^2 + a_2 * sin(pi*-1/2) = 0.5
% a_0 + a_1 *  0^2 + a_2 * sin(pi*0/2)  = 1
% a_0 + a_1 *  2^2 + a_2 * sin(pi*2/2)  = 5
% a_0 + a_1 *  3^2 + a_2 * sin(pi*3/2)  = 9
%
A = [1, 1, sin(-pi/2);
     1, 0, sin(0);
     1, 4, sin(pi);
     1, 9, sin(pi*3/2)];
b = [0.5;
     1;
     5;
     9];
a = normal_approximation(A, b)
solution_error = a - A\b

f = @(x, a) a(1) + a(2) * x.^2 + a(3) * sin(pi.*x/2);

pairs = [-1, 0.5; 0, 1; 2, 5; 3, 9];
x_fun = -2:0.1:4;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
legend("Data pairs", ...
    "f(x) = " + a(1) + " + " + a(2) + " * x^2 + " + a(3) + " * sin(pi*x/2)")
%% Problem 3
%
% y = a_0 + a_1 * x_1 + a_2 * x_2 + a_3 * x_3
A = [1, 50, 18, 10;
     1, 40, 20, 16;
     1, 35, 14, 10;
     1, 40, 12, 12;
     1, 30, 16, 14];
b = [28;
     30;
     21;
     23;
     23];
a = normal_approximation(A, b)
solution_error = a - A\b
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
normal_approximation_error = a - A\b
pairs = [1, 1.5; 2, 2; 3, 2.8; 4, 4.1; 5, 4.9; 6, 6.3; 7, 5; 8, 11.5];
a = linear_regression(pairs(:,1), pairs(:,2))
linear_regression_error = sum((pairs(:,2)-a(1)-a(2).*pairs(:,1)).^2)

f = @(x, a) a(1) + a(2) * x;

x_fun = 0:0.1:9;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
legend("Data pairs", ...
    "f(x) = " + a(1) + " + " + a(2) + " * x")

%% Problem 5
%
% y = a_0 + a_1 * x + a_2 * x^2
pairs = [0, 0; 0.25, 8; 0.5, 15; 0.75, 19; 1, 20];
x = pairs(:,1);
y = pairs(:,2);
A = [1,    0,    0^2;
     1, 0.25, 0.25^2;
     1, 0.50, 0.50^2;
     1, 0.75, 0.75^2;
     1, 1.00, 1.00^2];
b = [ 0;
      8;
     15;
     19;
     20];
a = normal_approximation(A, b)
a_0 = a(1);
a_1 = a(2);
a_2 = a(3);
linear_regression_error = sum((y-a_0-a_1.*x-a_2*x.^2).^2)
discriminant = a_1^2-4*a_2*a_0;
x_1 = (-a_1-sqrt(discriminant)) / (2*a_2)
x_2 = (-a_1+sqrt(discriminant)) / (2*a_2)

f = @(x, a) a(1) + a(2) * x + a(3) * x.^2;

x_fun = -1:0.1:2.1;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
xlim([0 1.1*max([x_1, x_2])])
ylim([0 1.1*max(y)])
legend("Data pairs", ...
    "f(x) = " + a(1) + " + " + a(2) + " * x" + a(3) + " * x^2")
%% Problem 6
%
x = [-5; -4; -3; -2; -1; 0; 1; 2; 3; 4; 5];
y = [2; 7; 9; 12; 13; 14; 14; 13; 10; 8; 4];
% y = a_0 + a_1 * x
A = [ones(size(x)), x];
b = y;
a_lin = normal_approximation(A, b);

x_fun = min(x)-1:0.1:max(x)+1;

f_lin = @(x, a) a(1) + a(2) .* x;
y_fun_lin = f_lin(x_fun, a_lin);
% y = a_0 + a_1 * x + a_2 * x^2
A = [ones(size(x)), x, x.^2];
b = y;
a_qua = normal_approximation(A, b);

f_qua = @(x, a) a(1) + a(2) .* x + a(3) * x.^2;
y_fun_qua = f_qua(x_fun, a_qua);

linear_regression_error = norm(y - f_lin(x, a_lin))
quadratic_regression_error = norm(y - f_qua(x, a_qua))

plot(x, y, "*", x_fun, y_fun_lin, x_fun, y_fun_qua)
xlabel("x")
ylabel("y")
ylim([min(y)-1, max(y)+1])
legend("Data pairs", ...
    sprintf("f(x) = %f + %f * x", a_lin), ...
    sprintf("g(x) = %f + %f * x + %f * x^2", a_qua))
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

function a = linear_regression(x, y)
% LINEAR_REGRESSION
%   a = linear_regression(x, y) returns the vector with the slope and
%     intercept of the line y = a_0 + a_1*x, which best fits
%     the data set of points (x_i, y_i).
%
%   Arguments:
%     x --- Vector of the first data point elements.
%     y --- Vector of the second data point elements.

N = length(x);
M = length(y);
if N ~= M
     error('The data set vectors must have the same length!')
end

a_1 = ( sum(y.*x) - M*mean(y)*mean(x) ) / ( sum(x.^2) - M*mean(x)^2 );
a_0 = mean(y) - a_1 * mean(x);
a = [a_0; a_1];

end
