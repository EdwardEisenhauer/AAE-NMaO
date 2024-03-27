clc;
clear all;
close all;

format shortEng;

A = [4 2 0 0;
     1 4 1 0;
     0 1 4 1;
     0 0 2 4];
thresholdVal = 1e-8;

[maxLambda, lambdas, convergence] = ScaledPowerMethod(A, 1000, thresholdVal);

figure;

plot(lambdas, '-o', 'DisplayName',"Value of dominant eigenvalue");
xlabel("Iteration");
ylabel("Value");
ylim([min(lambdas)-0.5 max(lambdas)+0.5])
yyaxis right;

semilogy(convergence,'-o', 'DisplayName', "Convergence rate");
yline(thresholdVal, '--', 'DisplayName', 'Convergennce Threshold')
set(gca,'yscale','log')
ylabel("Convergence value");
grid on
legend
xlim([1 length(lambdas)]);
title("Dominant lambda from scaled power method");

disp("Largest eigenvalue: ")
disp(maxLambda)

startingShift = 1.47;
[lambda lambdas convergence]= InversePowerMethod(A, startingShift, 1000, 1e-8);
figure;

plot(lambdas, '-o', 'DisplayName',"Value of searched eigenvalue");
xlabel("Iteration");
ylabel("Value");
ylim([min(lambdas)-0.5 max(lambdas)+0.5])
yyaxis right;

semilogy(convergence,'-o', 'DisplayName', "Convergence rate");
yline(thresholdVal, '--', 'DisplayName', 'Convergence Threshold')
set(gca,'yscale','log')
ylabel("Convergence value");
grid on
legend
xlim([1 length(lambdas)]);
title(sprintf("Eigenvalue from inverse power method with starting shift = %0.2f", startingShift));

disp("Smallest eigenvalue: ")
disp(lambda)