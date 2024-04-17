A = [3, -1;
     1,  2;
     2,  1];
b = [4;
     0;
     1];
x = normal_approximation(A, b)
implementation_error = x - A\b

x =

    1.0482
   -0.6747

implementation_error =

   1.0e-15 *

   -0.4441
    0.5551
