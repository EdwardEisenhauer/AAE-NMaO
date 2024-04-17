clc;
close all;
clear;
x_values = 1:14;
coeffs = [1 1 2 3 5 10 40];

original_y_values = polyval(coeffs, x_values);


estimate_sigma_value();
sigma_values = logspace(-8, -4, 600);
errors = zeros(size(sigma_values));
for i = 1:length(sigma_values)
    errors(i) = fit_with_noise(sigma_values(i), x_values, original_y_values, coeffs);
end
rng(1);
figure;
error_plot = loglog(sigma_values, errors, 'b-');
yline(1e-6, 'k--')
xlabel('Sigma values');
ylabel('Fitting Error');
title('Fitting Error vs. Sigma Values');
errors_copy = errors;
errors_copy(errors_copy < 1e-6) = NaN;
[~,closestIndex] = min(abs(errors-(1e-6)));
% closestIndex = find(errors > 1e-6)
datatip(error_plot,'DataIndex', closestIndex(1));
grid on;

rng(1);
for i = 1:closestIndex-1
    fit_with_noise(sigma_values(i), x_values, original_y_values, coeffs);
end

[~, noisy_y_values] = fit_with_noise(sigma_values(i), x_values, original_y_values, coeffs);
originalRLS = rot90(RecursiveLeastSquares(x_values, original_y_values, 7),3)
originalDirect = rot90(DirectMethod(x_values, original_y_values, 7),3)
noisyRLS = rot90(RecursiveLeastSquares(x_values, noisy_y_values, 7),3)
noisyDirect = rot90(DirectMethod(x_values, noisy_y_values, 7),3)

figure;
len = linspace(min(x_values), max(x_values), 500);
semilogy(len, polyval(coeffs, len), '', 'DisplayName', "Original values");
hold on
len = linspace(min(x_values), max(x_values), 50);
semilogy(len, polyval(originalDirect, len), 'x-.', 'DisplayName', "Direct method with original dataset");
semilogy(len, polyval(originalRLS, len), 'o--', 'DisplayName', "Recursive Least squares with noise");

semilogy(len, polyval(noisyDirect, len), 'x-.', 'DisplayName', "Direct method with original dataset");
semilogy(len, polyval(noisyRLS, len), 'o--', 'DisplayName', "Recursive Least squares with noise");

grid on;
lgd = legend;
lgd.ItemHitFcn = @ToggleLegend;

disp("originalDirect - noisyDirect")
originalDirect - noisyDirect


disp("originalRLS - noisyRLS")
originalRLS - noisyRLS

function [error,noisy_y_values] = fit_with_noise(sigma, x_values, original_y_values, coeffs)
    noisy_y_values = original_y_values + sigma * randn(size(original_y_values));
    noisy_coeffs = polyfit(x_values, noisy_y_values, 6);    
    error = norm(coeffs - noisy_coeffs);
end

function estimate_sigma_value();
    x = 1:14;
    A = [ones(length(x), 1), x', x'.^2, x'.^3, x'.^4, x'.^5, x'.^6];
    AtA = A' * A;
    AtA_inv = inv(AtA);
    AtA_inv = trace(AtA_inv);
    required_sigma = sqrt(10^(-12) / AtA_inv);
    
    fprintf('Required sigma for error < 10^-6: %e\n', required_sigma);
end