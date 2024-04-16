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

x =

    1.8072
    0.5585
   -0.3810

solution_error =

   1.0e-15 *

         0
   -0.1110
   -0.0555
