A = [0.835 0.667;
     0.333 0.266];
b = [0.168; 0.067];
bp = [0.168; 0.067];

B_1 = gaussian_elimination(A,b);
x_exact = back_substitution(B_1(:, 1:end - 1), B_1(:, end))

B_2 = gaussian_elimination(A,bp);
x_exact_2 = back_substitution(B_2(:, 1:end - 1), B_2(:, end))

n = size(A,2);
x_init = zeros(n, 1);
k_max = 100;

alpha = 0.1;
[x_sor, e_sor] = sor(A, bp, x_init, k_max, 1e-6, x_exact_2, 1);
[x_kaczmarz, e_kaczmarz]=kaczmarz(A,bp,x_init,k_max,1e-6,x_exact_2);
plot(1:k_max,e_sor,1:k_max,e_kaczmarz);
xlabel("Iteration");
ylabel("Solution error");
legend("SOR","Kaczmarz");
