function [v,beta] = householder(x)
% householder takes vertical vector x

if ~iscolumn(x)
    x = x.';
end

n = length(x);
sig = x(2:n).' * x(2:n);
v = [1; 
     x(2:n)];

 if isempty(sig) || (sig == 0)
     beta = 0;
 else
     mu = sqrt(x(1)^2+sig);
     if x(1) <= 0
         v(1) = x(1) - mu;
     else
         v(1) = -sig/(x(1) + mu);
     end
     beta = 2*v(1)^2/(sig + v(1)^2);
     v = v/v(1);
 end

end

