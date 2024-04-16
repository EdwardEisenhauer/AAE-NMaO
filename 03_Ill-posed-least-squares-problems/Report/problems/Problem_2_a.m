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

a =

    3.0000
   -2.2500
   -1.2500

solution_error =

   1.0e-15 *

    0.4441
   -0.4441
   -0.2220
