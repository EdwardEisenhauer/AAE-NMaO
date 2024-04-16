f = @(x, a) a(1) + a(2) * x.^2 + a(3) * sin(pi.*x/2);

pairs = [0, 3; 1, 0; 1, -1; -1, 2];
x_fun = -2:0.1:2;
y_fun = f(x_fun, a);

plot(pairs(:,1), pairs(:,2), "*", x_fun, y_fun)
xlabel("x")
ylabel("y")
legend("Data pairs", ...
    "y = " + a(1) + " + " + a(2) + " * x^2 + " + a(3) + " * sin(pi*x/2)")
