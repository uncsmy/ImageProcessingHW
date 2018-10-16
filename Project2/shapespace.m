function [eigv_x,eigv_y,var_x,var_y,mean_pdm] = shapespace(pdms_matrix, training)
    
    pdms_training = pdms_matrix(:,training);
    mean_pdm = mean(pdms_training,2);
    mean_x = mean_pdm(1:2:end);
    mean_y = mean_pdm(2:2:end);
    x_matrix = pdms_training(1:2:end,:);
    y_matrix = pdms_training(2:2:end,:);
    [p,n] = size(pdms_training);
    
    X = x_matrix - repmat(mean_x,1,n);
    Y = y_matrix - repmat(mean_y,1,n);

    % PCA to get eigenvalue and eigenvectors
    [eigv_x,scr_x,var_x] = pca(X');
    [eigv_y,scr_y,var_y] = pca(Y');

end





















