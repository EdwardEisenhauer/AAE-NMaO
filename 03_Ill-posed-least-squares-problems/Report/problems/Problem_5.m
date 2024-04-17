pairs = [0, 0; 0.25, 8; 0.5, 15; 0.75, 19; 1, 20];
x = pairs(:,1);
y = pairs(:,2);
A = [1,    0,    0^2;
     1, 0.25, 0.25^2;
     1, 0.50, 0.50^2;
     1, 0.75, 0.75^2;
     1, 1.00, 1.00^2];
b = [ 0;
      8;
     15;
     19;
     20];
a = normal_approximation(A, b)
a_0 = a(1);
a_1 = a(2);
a_2 = a(3);
linear_regression_error = sum((y-a(1)-a(2).*x-a(3)*x.^2).^2)
discriminant = a_1^2-4*a_2*a_0;
x_1 = (-a_1-sqrt(discriminant)) / (2*a_2)
x_2 = (-a_1+sqrt(discriminant)) / (2*a_2)

a =

   -0.2286
   39.8286
  -19.4286

linear_regression_error =

    0.4571

x_1 =

    2.0442

x_2 =

    0.0058
