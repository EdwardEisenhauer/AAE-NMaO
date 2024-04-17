function a = linear_regression(x, y)
% LINEAR_REGRESSION
%   a = linear_regression(x, y) returns the vector with the slope and
%     intercept of the line y = a_0 + a_1*x, which best fits
%     the data set of points (x_i, y_i).
%
%   Arguments:
%     x --- Vector of the first data point elements.
%     y --- Vector of the second data point elements.

N = length(x);
M = length(y);
if N ~= M
        error('The data set vectors must have the same length!')
end

a_1 = ( sum(y.*x) - M*mean(y)*mean(x) ) / ( sum(x.^2) - M*mean(x)^2 );
a_0 = mean(y) - a_1 * mean(x);
a = [a_0; a_1];

end
