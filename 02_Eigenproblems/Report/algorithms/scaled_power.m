function [x_1,lambda_1]=scaled_power(A,i)
%The scaled power algorithm
%Is an iterative technique
%for computing a dominant eigenpair.
%
% A---- diagonalizable matrix
%
% i---- number of iterations


n=length(A);
x_1=ones(n,1);%random non zero vector
for k=1:i-1
    x_1=A*x_1;%vector overwrite
    x_1=x_1/norm(x_1);%normalization
end
lambda_1 =(x_1'*A*x_1)/(x_1'*x_1);%Rayleigh quotient:
end
