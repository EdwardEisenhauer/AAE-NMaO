function A = Alg1_outer_product_gaussian_elimination(A)
% ADDME Algorithm 1: Outer Product Gaussian Elimination (Golub, Loan, 3.2.1)


[n, m] = size(A);
if n ~= m
    error('Matrix is not squared!')
end
    
%  if det(A) == 0
%     error('Matrix is not nonsingular!')
%  end
 
 for k = 1 : n-1
     rows = k + 1 : n;
     A(rows, k) = A(rows, k)/A(k, k);
     A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
 end
 
end