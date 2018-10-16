function new_pdm = normalization(pdm)
    % pdm and new_pdm is a p by 1 vector
    % normalize a pdm to a new pdm
    [p,~] = size(pdm);
    x_mean = mean(pdm(1:2:end));
    y_mean = mean(pdm(2:2:end));
    mean_v = zeros(p,1);
    mean_v(1:2:end) = x_mean;
    mean_v(2:2:end) = y_mean;

    pdm = pdm-mean_v;
    r_m = zeros(2,2);
    r_m(1,1) = sum(pdm(1:2:end).^2);
    r_m(1,2) = sum(pdm(1:2:end).*pdm(2:2:end));
    r_m(2,1) = sum(pdm(1:2:end).*pdm(2:2:end));
    r_m(2,2) = sum(pdm(2:2:end).^2);
    [V,D] = eig(r_m);
    rotation = [V(:,2),V(:,1)];
    rotation = rotation';

    new_pdm = [];
    for i = 1:(p/2)
        point = [pdm(2*i-1);pdm(2*i)];
        point_r = rotation*point;

        new_pdm = [new_pdm;point_r];
    end
end

