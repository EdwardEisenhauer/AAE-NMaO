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

a =

   -0.3964
    1.1464

normal_approximation_error =

   1.0e-14 *

    0.3442
   -0.0222

a =

   -0.3964
    1.1464

linear_regression_error =

    15.1982
