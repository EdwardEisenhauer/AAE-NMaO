A = [1, 1, 1; 1, 1, 2; 1, 2, 2];
b = [1;2;1];
rho_landweber = 2*abs(max(eig(A'*A)))^(-1)
x_real = A\b
tic
landweber(A,b, [0;0;0], 10000, 1e-5,x_real, rho_landweber/2)
toc
tic
kaczmarz(A,b, [0;0;0], 10000, 1e-5,x_real)
toc

rho_landweber =

    0.1144


x_real =

     1
    -1
     1

Converged successfully after 1046 iterations.
ans =

    1.0000
   -1.0000
    1.0000
Elapsed time is 0.002480 seconds.

Converged successfully after 146 iterations.
ans =

    1.0000
   -1.0000
    1.0000
Elapsed time is 0.000897 seconds.