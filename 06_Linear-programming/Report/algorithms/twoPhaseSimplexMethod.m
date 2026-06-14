function [tab, x_final] = twoPhaseSimplexMethod(A, b, f)
    b = reshape(b, [length(b), 1]);
    f = reshape(f, [1, length(f)]);
    [rows, cols] = size(A);

    % FIRST PHASE
    last_tmp = -sum(A(:, 1:cols), 1)';

    last_tmp2 = [last_tmp; zeros(rows, 1)];

    last = [last_tmp2; -sum(b)];

    tab = [A, eye(rows), b; last'];

    [tab_rows, tab_cols] = size(tab);

    while true
        if all(tab(tab_rows, 1:tab_cols-1) >= -eps(1))
            break;
        end

        [min_tab, argmin_tab] = min(tab(end, 1:cols));

        if min_tab == 0
            break;
        end

        ratios = tab(1:rows, end) ./ tab(1:rows, argmin_tab);

        for i = 1:rows
            if tab(i, argmin_tab) <= 0
                ratios(i) = 0;
            end
        end

        valid_ratios = ratios(ratios > 0);
        if isempty(valid_ratios)
            break;
        end
        min_r = min(valid_ratios);
        index = find(ratios == min_r, 1, 'last');

        tab(index, :) = tab(index, :) / tab(index, argmin_tab);

        for i = 1:rows+1
            if i ~= index
                tab(i, :) = tab(i, :) - tab(i, argmin_tab) * tab(index, :);
            end
        end
    end

    % SECOND PHASE
    tab = [tab(1:rows, 1:cols), tab(1:rows, tab_cols); [f, 0]];

    columns = [];
    n = zeros(1, cols);
    for i = 1:cols
        v = tab(find(tab(1:tab_rows-1, i)), i);
        if numel(v) == 1
            if v == 1
                columns = [columns, i];
                finding = find(tab(:, i));
                if ~isempty(finding)
                    n(i) = finding(1);
                end
            end
        end
    end

    for i = 1:length(columns)
        p_col = columns(i);
        p_row = n(p_col);
        tab(p_row, :) = tab(p_row, :) / tab(p_row, p_col);

        for j = 1:rows+1
            if j ~= p_row
                tab(j, :) = tab(j, :) - tab(j, p_col) * tab(p_row, :);
            end
        end
    end

    % SIMPLEX ALGORITHM
    [tab_rows, tab_cols] = size(tab);
    while true
        if all(tab(tab_rows, 1:tab_cols-1) >= 0)
            break;
        end

        [min_tab, argmin_tab] = min(tab(end, 1:cols));

        if min_tab == 0
            break;
        end

        ratios = tab(1:rows, end) ./ tab(1:rows, argmin_tab);

        for i = 1:rows
            if tab(i, argmin_tab) <= 0
                ratios(i) = 0;
            end
        end

        valid_ratios = ratios(ratios > 0);
        if isempty(valid_ratios)
            break;
        end
        min_r = min(valid_ratios);
        index = find(ratios == min_r, 1, 'last');

        tab(index, :) = tab(index, :) / tab(index, argmin_tab);

        for i = 1:rows+1
            if i ~= index
                tab(i, :) = tab(i, :) - tab(i, argmin_tab) * tab(index, :);
            end
        end
    end

    % EXTRACT SOLUTION
    x_final = zeros(1, cols);
    n = zeros(1, cols);

    for i = 1:cols
        v = tab(find(tab(:, i)), i);
        if numel(v) == 1
            if v == 1
                finding = find(tab(:, i));
                if ~isempty(finding)
                    x_final(i) = tab(finding(1), end);
                end
            end
        end
    end
end
