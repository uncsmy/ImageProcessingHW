function [ Unow, center, now_obj_fcn ] = FCMforImage( img, clusterNum )

if nargin < 2
    clusterNum = 2;   % number of cluster
end

[nrow, ncol] = size(img);
m = 2;      % fuzzification parameter
epsilon = 0.001;  % stopping condition
max_iter = 100;   % number of maximun iteration

% initilize U matrix
Upre = rand(nrow, ncol, clusterNum);
dep_sum = sum(Upre, 3);
dep_sum = repmat(dep_sum, [1,1, clusterNum]);
Upre = Upre./dep_sum;

% initilize center
center = zeros(clusterNum,1);
for i=1:clusterNum
    center(i,1) = sum(sum(Upre(:,:,i).*img))/sum(sum(Upre(:,:,i)));
end

% initilize obj_fcn
pre_obj_fcn = 0;
for i=1:clusterNum
    pre_obj_fcn = pre_obj_fcn + sum(sum((Upre(:,:,i) .*img - center(i)).^2));
end
fprintf('Initial objective fcn = %f\n', pre_obj_fcn);

for iter = 1:max_iter    
    Unow = zeros(size(Upre));
    for i=1:nrow
        for j=1:ncol
            for uII = 1:clusterNum
                tmp = 0;
                for uJJ = 1:clusterNum
                    disUp = abs(img(i,j) - center(uII));
                    disDn = abs(img(i,j) - center(uJJ));
                    tmp = tmp + (disUp/disDn).^(2/(m-1));
                end
                Unow(i,j, uII) = 1/(tmp);
            end            
        end
    end   

    now_obj_fcn = 0;
    for i=1:clusterNum
        now_obj_fcn = now_obj_fcn + sum(sum((Unow(:,:,i) .*img - center(i)).^2));
    end
    fprintf('Iteration = %d, Objective = %f\n', iter, now_obj_fcn);

    if abs(now_obj_fcn - pre_obj_fcn)<epsilon 
        break;
    else
        Upre = Unow.^m;
        for i=1:clusterNum
            center(i,1) = sum(sum(Upre(:,:,i).*img))/sum(sum(Upre(:,:,i)));
        end
        pre_obj_fcn = now_obj_fcn;
    end
end
