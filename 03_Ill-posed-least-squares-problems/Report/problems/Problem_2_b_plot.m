f = @(x, a) a(1) + a(2) * x.^2 + a(3) * sin(pi.*x/2);

pairs = [-1, 0.5; 0, 1; 2, 5; 3, 9];
x_fun = -2:0.1:4;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
legend("Data pairs", ...
    "f(x) = " + a(1) + " + " + a(2) + " * x^2 + " + a(3) + " * sin(pi*x/2)")
