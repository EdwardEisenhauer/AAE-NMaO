A = [ 1,  3,  1;
     -1, -2,  1;
      3,  7, -1];

p      = 0.1;
lambda = 1e-8;
tol    = 1e-8;

b_a = [10; -5; 20];
x_a = focuss(A, b_a, p, lambda, tol)

b_b = [1; 1; -1];
x_b = focuss(A, b_b, p, lambda, tol)

b_c = [1; 0; 1];
x_c = focuss(A, b_c, p, lambda, tol)

FOCUSS: reached max_iter = 10000

x_a =

         0
    3.0000
    1.0000


x_b =

   -0.0000
   -0.0000
    1.0000


x_c =

    0.0000
    0.2000
    0.4000
