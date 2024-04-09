function x = normal_approximation(A, b)

x = (A' * A) \ A' * b;

end
