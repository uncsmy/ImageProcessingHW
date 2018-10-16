function [coeffs_x,coeffs_y] = testimages(test,pdms_matrix,eigv_x,eigv_y,var_x,var_y,k)
    % pdms_matrix: row as points, columns as samples - p by n
    load('greyimages.mat');
    p = 64;

    % normal mathematical corrodinates
    [X_line,~] = meshgrid(1:256);
    [~,Y_line] = meshgrid(256:-1:1);

    % test images
    test_pdm = pdms_matrix(:,test);
    greyimage = reshape(greyimages(:,25),256,256);
    [imgderx,imgdery] = Derivative(greyimage,1);
    % do I need to convert rgb to gray scale

    % get norm-direction
    test_pdm_up = [test_pdm(3:end);test_pdm(1:2)];
    test_pdm_down = [test_pdm((2*p-1):2*p);test_pdm(1:(2*p-2))];
    up_diff = test_pdm_up - test_pdm;
    down_diff = test_pdm_down - test_pdm;
    up_diff = transpose(reshape(up_diff,2,p));
    down_diff = transpose(reshape(down_diff,2,p));

    up_leng = sqrt(up_diff(:,1).^2 + up_diff(:,2).^2);
    down_leng = sqrt(down_diff(:,1).^2 + down_diff(:,2).^2);

    up_norm = [-up_diff(:,2),up_diff(:,1)]./repmat(up_leng,1,2);
    down_norm = [-down_diff(:,2),down_diff(:,1)]./repmat(down_leng,1,2);

    norm_direc = (up_norm + down_norm)/2;

    coeffs_x = [];
    coeffs_y = [];
    temp_pdm = transpose(reshape(test_pdm,2,64));

    % iteration for convergence
    for j = 1:20
        j
        % generate match value of 11 points for 64 boundary points
        match_value = [];

        ran = -5:5;
        for i = ran
            exten = temp_pdm+i*norm_direc+ 128*ones(64,2);
            gx = interp2(X_line,Y_line,imgderx,exten(:,1),exten(:,2));
            gy = interp2(X_line,Y_line,imgdery,exten(:,1),exten(:,2));
            product = exten(:,1).*gx + exten(:,2).*gy;
            match_value = [match_value, product];
        end

        % find index of max match value and generate new pdm
        [max_val,ind] = max(match_value,[],2);
        new_pdm = temp_pdm + repmat(ran(ind)',1,2).*norm_direc;

        % prjection
        [b_x,b_y] = projection(new_pdm(:,1)',new_pdm(:,2)',eigv_x,eigv_y,var_x,var_y,k);
        coeffs_x = [coeffs_x;b_x];
        coeffs_y = [coeffs_y;b_y];

        temp_pdm = new_pdm;
end
end









