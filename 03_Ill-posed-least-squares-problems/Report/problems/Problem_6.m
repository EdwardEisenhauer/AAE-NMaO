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

linear_regression_error =

    12.7636
 
quadratic_regression_error =
 
     1.2737
