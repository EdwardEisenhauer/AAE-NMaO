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

a =

    0.9000
    1.0500
    1.4000

solution_error =

   1.0e-14 *

   -0.0666
   -0.0444
   -0.1554
