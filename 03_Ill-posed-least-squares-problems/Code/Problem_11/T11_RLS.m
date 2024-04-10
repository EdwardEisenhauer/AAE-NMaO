clear all;
close all
clc;

x = 1:14;
yf = @(x)(40 + 10*x + 5*x.^2 + 3*x.^3 + 2*x.^4 + x.^5 + x.^6);
y = yf(x);

theta_hat = RecursiveLeastSquares(x, y, 7);
% theta_hat = DirectMethod(x, y, 7);
len = linspace(min(x), max(x), 500);

res = zeros(size(len));
for i = 0:length(theta_hat)-1
    res = res + theta_hat(i+1)*len.^i;
end

semilogy(x, y, 'o');
hold on;
title('Original Data Points and Approximated Curves');

semilogy(len, res, 'g-');
grid on;
xlabel('x');
ylabel('y');


hold on;

theta_hat = DirectMethod(x, y, 7);
res = zeros(size(len));
for i = 0:length(theta_hat)-1
    res = res + theta_hat(i+1)*len.^i;
end
semilogy(len, res, 'r-');
grid on;
xlabel('x');
ylabel('y');
lgd = legend;
hold off;

lgd.ItemHitFcn = @ToggleLegend;