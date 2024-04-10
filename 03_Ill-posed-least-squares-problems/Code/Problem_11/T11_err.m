clear all
close all
clc
warning('off','all')
x = 1:14;
yf = @(x)(40 + 10*x + 5*x.^2 + 3*x.^3 + 2*x.^4 + x.^5 + x.^6);
y = yf(x);
param_num = 7;
sigma_range = 0:0.0001:0.1;
functions = {@DirectMethod, @RecursiveLeastSquares};
function_names = ["Direct method", "Recursive least squares"];
sigma_max = EstimateSigmaMax(x, y, param_num, sigma_range, functions, function_names, yf);

function sigma_max = EstimateSigmaMax(x, y, param_num, sigma_range, functions, function_names, yf)
    len = linspace(min(x), max(x), 500);
    original_params = yf(len);
    
    fitting_errors = zeros(2,size(sigma_range,2));
    sigma_max = 0;
    
    for i = 1:length(sigma_range)
        y_noisy = y + sigma_range(i) * randn(size(y));

        for j = 1:length(functions)
            estimated_params = functions{j}(x, y_noisy, param_num );
            fitted_data = zeros(size(x));
            for k = 1:length(x)
                for l = 1:param_num
                    fitted_data(k) = fitted_data(k) + estimated_params(l) * x(k)^(l-1);
                end
            end
            fitting_errors(j,i) = norm(y_noisy - fitted_data);
        end


    end
    fitting_errors;
    figure;
    for j = 1:size(functions,2)
        plot(sigma_range, fitting_errors(j,:), 'LineWidth', 2/j, 'DisplayName', ...
            sprintf("Fitting errors for %s",function_names(j)));
            hold on;
    end
    xlabel('\sigma');
    ylabel('Fitting Error');
    title('Fitting Error vs. Standard Deviation of Noise');
    grid on;
    lgd = legend;
    lgd.ItemHitFcn = @ToggleLegend;
end
