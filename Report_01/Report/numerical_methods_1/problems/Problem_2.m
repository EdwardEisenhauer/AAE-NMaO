clear all;
clc;
A = [1, 1, 1;
     1, 1, 2;
     1, 2, 2];
b = [1;
     2;
     1];
B = gaussian_elimination_with_partial_pivoting(A, b);
x = back_substitution(B(:, 1:end - 1), B(:, end))

x =

     1
    -1
     1
