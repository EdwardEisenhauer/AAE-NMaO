clear all;
close all;
clc;
A = [1 2 2 3 1;
     2 4 4 6 2;
     3 6 6 9 6;
     1 2 4 5 3];

x = [1; 0; 1; 1; 0];
b = A*x;


disp("Base A vector")
rankA = rank(A)

A_pinv = pinv(A);

x_hat = A_pinv*b
FOCUSS = focuss(A,b, 1, 1e-3, 10e-7, 1000)
MFOCUSS = mfocuss(A,b, 1, 1e-3, 10e-7, 1000)

A = [1 2 2 3 1;
     0 4 4 6 2;
     3 6 6 9 6;
     1 2 4 5 3];

x = [1; 0; 1; 1; 0];
b = A*x;

A_pinv = pinv(A);
disp("Modified A vector")
rankA_modified = rank(A)
x_hat = A_pinv*b
FOCUSS = focuss(A,b, 1, 1e-3, 10e-7, 1000)
MFOCUSS = mfocuss(A,b, 1, 1e-3, 10e-7, 1000)

Base A vector

rankA =

     3


x_hat =

    0.1818
    0.3636
    0.9091
    1.0909
    0.0000


FOCUSS =

    0.0000
    0.0000
    0.0000
    2.0000
    0.0000


MFOCUSS =

    0.1008
    0.4030
    0.6660
    1.2848
    0.0032

Modified A vector

rankA_modified =

     4


x_hat =

    1.0000
   -0.0000
    1.0000
    1.0000
   -0.0000


FOCUSS =

    0.9993
    0.0000
    0.9988
    1.0007
    0.0005


MFOCUSS =

    0.9989
    0.0000
    0.9987
    1.0006
    0.0130
