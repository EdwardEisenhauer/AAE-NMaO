clc;
clear all;
close all;

A_1 = [-2 -1 0; 2 0 0; 0 0 2];
A_2 = [5 1 1; 0 6 1; 0 0 -5];
A_3 = [5.2 0.6 2.2; 0.6 6.4 0.5; 2.2 0.5 4.7];

Gershgorin(A_1)
Gershgorin(A_2)
Gershgorin(A_3)

