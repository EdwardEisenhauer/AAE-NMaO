function gershgorin(A)
% GERSHGORIN Gershgorin disks.
%
%  gershgorin(A) Draws the Gershgorin disks for the matrix A.
%
%  Arguments:
%    A --- The matrix for which the Gershorin disks will be drawn.

[m, n] = size(A);

if m ~= n
    error('The matrix A is not square!')
end

c = diag(A);
r_row = sum(abs(A), 2) - abs(c);
r_col = sum(abs(A), 1)' - abs(c);
l = eig(A);

theta = linspace(0,2*pi);

Gr = repmat(polyshape,m,1);
Gc = repmat(polyshape,m,1);

figure
hold on
grid on
axis equal
xlabel('Re')
ylabel('Im')

for i = 1:length(c)
    if r_row(i) > eps
       X = r_row(i)*cos(theta) + c(i);
       Y = r_row(i)*sin(theta);
       plot(X, Y, '--blue')
       Gr(i) = polyshape(X,Y);
    end
    if r_col(i) > eps
       X = r_col(i)*cos(theta) + c(i);
       Y = r_col(i)*sin(theta);
       plot(X, Y, '--green')
       Gc(i) = polyshape(X,Y);
    end
end

plot(intersect(union(Gr),union(Gc)), 'FaceColor', 'red')
plot(real(c), imag(c), 'xk', 'LineWidth', 1.5,'MarkerSize', 15)
plot(real(l), imag(l), '+r', 'LineWidth', 1.5,'MarkerSize', 15)

end
