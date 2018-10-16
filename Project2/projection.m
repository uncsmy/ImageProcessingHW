function [b_x,b_y] = projection(X,Y,eigv_x,eigv_y,var_x,var_y,k)
% rows of X,Y should be samples
% extract k max pcs
eigv_x = eigv_x(:,1:k);
eigv_y = eigv_y(:,1:k);
sigma_x = sqrt(var_x(1:k));
sigma_y = sqrt(var_y(1:k));

b_x = X*eigv_x; % n,k
b_y = Y*eigv_y;

[n,p] = size(X);
a_x = b_x./repmat(sigma_x',n,1);
a_y = b_y./repmat(sigma_y',n,1);

a_x(a_x < -2.5) = -2.5;
a_x(a_x > 2.5) = 2.5;
a_y(a_y < -2.5) = -2.5;
a_y(a_y > 2.5) = 2.5;

b_x = a_x.* repmat(sigma_x',n,1);
b_y = a_y.* repmat(sigma_y',n,1);

end