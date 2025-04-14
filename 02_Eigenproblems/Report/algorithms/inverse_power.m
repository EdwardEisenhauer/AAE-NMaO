function [lamda,x]=inverse_power(A,i)
%The Inverse power method is an iterative technique
%for computing the smalest eigenpair.
%
% A---- diagonalizable matrix
%
% i---- number of iterations
%
[n,m]=size(A);
x=rand(n,1);
alpha = 0.001;% value shift 
B= inv (A-alpha*eye(n));
for i=1:i
    x=B*x;%updating matrix
    x=x/norm(x);%normalization
end
lambda =(x'*A*x)/(x'*x);%Rayleigh quotient:
end
