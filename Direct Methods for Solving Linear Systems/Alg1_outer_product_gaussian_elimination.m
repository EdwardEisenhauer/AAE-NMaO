function A = Alg1_outer_product_gaussian_elimination(A)
% Algorithm 1: Outer Product Gaussian Elimination (Golub, Loan, 3.2.1)
% Performs a gaussian eliminaion on a square matrix A.

    [m, n] = size(A);

    if m ~= n
        error('Matrix is not squared!')
    end
    
%  if det(A) == 0
%     error('Matrix is not nonsingular!')
%  end
 
    for k = 1 : m-1
     rows = k + 1 : m;
     A(rows, k) = A(rows, k)/A(k, k);
     A(rows, rows) = A(rows, rows) - A(rows, k) * A(k, rows);
    end
 
end