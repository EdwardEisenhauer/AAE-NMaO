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
            plottedLine = plot(x, y, '--', 'LineWidth',2);
            plot(centers(i), 0, 'ko', 'MarkerFaceColor', get(plottedLine, 'Color'))
        else
            plot(centers(i), 0, '*', 'MarkerSize', 10); 
        end
        plot(real(eigen(i)), imag(eigen(i)), 'kx', 'MarkerSize', 10, 'LineWidth', 2)
    end
end
