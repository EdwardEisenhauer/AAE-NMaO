A = [3,  1,  1;
     2,  3, -1;
     2, -1,  1;
     3, -3,  3];
b = [6;
     1;
     0;
     8];
x = normal_approximation(A, b)
implementation_error = x - A\b

x =

   -1.6667
    3.8333
    7.9167

implementation_error =

   1.0e-14 *

    0.3997
   -0.4885
   -0.6217
