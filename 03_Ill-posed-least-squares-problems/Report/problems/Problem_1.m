%% Problem 1 Task a
A = [3, -1;
     1,  2;
     2,  1];
b = [4;
     0;
     1];
x = normal_approximation(A, b)
x - A\b

x =

    1.0482
   -0.6747

ans =

   1.0e-15 *

   -0.4441
    0.6661

%% Problem 1 Task b
A = [3,  1,  1;
     2,  3, -1;
     2, -1,  1;
     3, -3,  3];
b = [6;
     1;
     0;
     8];
x = normal_approximation(A, b)
x - A\b

x =

   -1.6667
    3.8333
    7.9167

ans =

   1.0e-14 *

    0.3331
   -0.6661
   -0.9770

%% Problem 1 Task c
A = [ 1,  1, -1;
      2, -1,  6;
     -1,  4,  1;
      3,  2, -1];
b = [5;
     1;
     0;
     6];
x = normal_approximation(A, b)
x - A\b

x =

    1.8072
    0.5585
   -0.3810

ans =

   1.0e-15 *

         0
   -0.1110
   -0.0555
