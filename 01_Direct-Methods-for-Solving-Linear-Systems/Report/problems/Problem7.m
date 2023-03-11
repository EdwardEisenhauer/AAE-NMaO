A = hilb(5);
[L, U] = Alg7(A);
cond(A)
L*U - A
prod(diag(U)) - det(A)

ans =

   4.7661e+05
   
ans =

   1.0e-16 *

         0         0         0         0         0
         0         0         0         0         0
         0         0         0         0         0
         0         0         0         0   -0.1388
         0         0         0   -0.1388         0


ans =

   1.6620e-23