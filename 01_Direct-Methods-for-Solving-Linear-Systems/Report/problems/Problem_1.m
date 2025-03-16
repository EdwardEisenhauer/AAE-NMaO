A = [2, -1,  0,  0;
    -1,  2, -1,  0;
     0, -1,  2, -1;
     0,  0, -1,  2];
b = [0;
     0;
     0;
     5];
B = gaussian_elimination(A, b);
x = back_substitution(B(:, 1:end - 1), B(:, end))

x =

    1.0000
    2.0000
    3.0000
    4.0000
