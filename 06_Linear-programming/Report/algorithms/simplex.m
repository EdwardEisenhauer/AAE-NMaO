function [tableau,x_sol] = simplex(f,A,b)
%   SIMPLEX
%   The simplex method finds the optimal solution of optimization problem
%
%   Arguments:
%     A --- Matrix of constrains.
%     b --- vector of solution.
%     f --- objective function.

%step 0 create tableu
[m,n]=size(A);
tableau=[A,eye(m),b];
f_mod=[f,zeros(1,m+1)];
tableau=[tableau;f_mod];
while true
    last_row=tableau(end,:);
    % Checking condition step 1
    if all(last_row(1:end-1)>=0)
        break;
    end
    %step 2 chose column with most negative r value
    [~,min_c]=min(last_row(1:length(f)));
    %step 3 calculate ratios
    ratios=tableau(1:m,end)./tableau(1:m,min_c);
    %only ratios>0
    positive_val=ratios(ratios>0);
    %if no positibe values
    if isempty(positive_val)
        error ('Problem is unbounded!')
    end
    min_ratio=min(positive_val);
    min_ratio_index = find(ratios == min_ratio, 1);
    %step 4 find pivot and update other rows
    tableau(min_ratio_index,:) = tableau(min_ratio_index,:) / tableau(min_ratio_index, min_c);
    for i = 1:m+1
        if i ~= min_ratio_index
            tableau(i, :) = tableau(i, :) - tableau(i, min_c) * tableau(min_ratio_index, :);
        end
    end
end
%Exact sol
x_sol=zeros(1,n);
[t_r,t_c]=size(tableau);

for k=1:n
    col=tableau(1:t_r,k);
    nonzero=col(col~=0);
    if isscalar(nonzero) && nonzero==1
        pick=find(tableau(:,k)==1,1);
        x_sol(k)=tableau(pick,end);
    end

end
