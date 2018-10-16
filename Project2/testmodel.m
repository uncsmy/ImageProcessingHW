load('correctpdms.mat')
n = 32;
p = 64;
training = 1:24;
test = 26;
k = 1;

pdms_matrix = [];
for i = 1:n
    pdm = correctpdms(:,i);
    new_pdm = normalization(pdm);
    pdms_matrix = [pdms_matrix,new_pdm];
end
% pdms_matrix is 2p by n (128 by 32)

[eigv_x,eigv_y,var_x,var_y,mean_pdm] = shapespace(pdms_matrix, training);

[test_x,test_y] = testimages(test,pdms_matrix,eigv_x,eigv_y,var_x,var_y,k);

predict_pdm_x = eigv_x(:,1:k) * test_x(20,:);
predicy_pdm_y = eigv_y(:,1:k) * test_y(20,:);

plot(predict_pdm_x,predict_pdm_y);