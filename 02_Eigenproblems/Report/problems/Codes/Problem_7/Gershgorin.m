function Gershgorin(A)
    centers = zeros(size(A,1),1);
    r = centers;
    for i  = 1:size(A,1)
        centers(i) = A(i,i);
        r(i) = sum(abs(A(i,:)));
        r(i) = r(i) - abs(A(i,i));
    end
    
    figure;
    hold on;
    axis equal;
    grid on;
    xlabel("Real axis")
    ylabel("Imaginary axis")
    eigen = eig(A);
    theta = linspace(0, 2*pi, 100); 
    for i = 1:length(centers)
        if r(i) > 0
            x = r(i) * cos(theta) + centers(i);
            y = r(i) * sin(theta);
            plottedLine = plot(x, y, '--', 'LineWidth',2, 'DisplayName','Gershgorin circle radius');
            plot(centers(i), 0, 'ko', 'MarkerFaceColor', get(plottedLine, 'Color'), 'DisplayName', 'Gershgorin circle center')
        else
            plot(centers(i), 0, '*', 'MarkerSize', 14, 'LineWidth', 2.5, 'DisplayName', 'Point without radius'); 
        end
        plot(real(eigen(i)), imag(eigen(i)), 'kx', 'LineWidth', 2, 'MarkerSize', 10, 'LineWidth', 2, 'DisplayName', "True eigenvalue position")
    end
    legend
    yline(0, '--k', 'HandleVisibility','off');
    xline(0, '--k', 'HandleVisibility','off');
end
