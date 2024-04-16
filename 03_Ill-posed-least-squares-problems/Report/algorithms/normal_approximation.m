function x = normal_approximation(A, b)
% NORMAL_APPROXIMATION
%   x = normal_approximation(A, b) returns the approximate least-squares
%     solution to the inconsistent system of linear equations Ax = b.
%
%   Arguments:
%     A --- Coefficient matrix.
%     b --- Column vector of constant terms.

x = inv(A' * A) * A' * b;

end
