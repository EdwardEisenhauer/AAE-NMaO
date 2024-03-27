A = [4 3; 1 2];  
a = A(1,1);
b = A(1,2);
c = A(2,1);
d = A(2,2);
trace_A = a + d;
det_A = a*d - b*c;
discriminant = sqrt(trace_A^2 - 4*det_A);
lambda1 = (trace_A + discriminant) / 2;
lambda2 = (trace_A - discriminant) / 2;

V = zeros(2);
V(:,1) = null(A - lambda1*eye(2));
V(:,2) = null(A - lambda2*eye(2)); 

D = diag([lambda1 lambda2]);

D_100 = D^100;

A_100 = V * D_100 / V;

disp(A_100);
