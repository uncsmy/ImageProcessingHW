function [center, U, obj_fcn] = kfcm(data, Vinit, options)

default_options = [2;	% fuzzy parameter m
		100;	% max. number of iteration
		1e-5;	% epsilon
		1;      % info display during iteration 
        10];	%sigma

% set options
if nargin == 2,
	options = default_options;
else

	if length(options) < 5,
		tmp = default_options;
		tmp(1:length(options)) = options;
		options = tmp;
	end

	nan_index = find(isnan(options)==1);
	options(nan_index) = default_options(nan_index);
	if options(1) <= 1,
		error('The exponent should be greater than 1!');
	end
end

expo = options(1);		% Exponent for U
max_iter = options(2);		% Max. iteration
e = options(3);		% Min. improvement
display = options(4);		
delta= options(5);	     	
obj_fcn = zeros(max_iter, 1);	% Array for objective function

center=Vinit;
cluster_n=length(Vinit);
k_dis=exp(-((abs(repmat(data',cluster_n,1)-repmat(center,1,length(data)))).^2)/(delta.^2));     %核函数下的距离，这里是使用的高四核，delta同上
U=((1-k_dis).^(-1/(expo-1)))  ./  repmat( sum((1-k_dis).^(-1/(expo-1)),1),cluster_n,1 );          %隶属度矩阵，cluster_n行，data个列

% Main loop
for i = 1:max_iter, 
    tmp0=sum(U.^expo.*k_dis.*repmat(data',cluster_n,1),2);
    tmp1=sum(U.^expo.*k_dis,2);
    center=tmp0./tmp1;
    
    k_dis=exp(-((abs(repmat(data',cluster_n,1)-repmat(center,1,length(data)))).^2)/(delta.^2));     %核函数下的距离，这里是使用的高四核，delta同上
    U=((1-k_dis).^(-1/(expo-1)))  ./  repmat( sum((1-k_dis).^(-1/(expo-1)),1),cluster_n,1 );          %隶属度矩阵，cluster_n行，data个列
    
    tmp=U.^2.*k_dis;
    obj_fcn(i)=sum(tmp(:));
	if display, 
		fprintf('Iteration count = %d, obj. fcn = %f\n', i, obj_fcn(i));
	end

	if i > 1,
		if abs(obj_fcn(i) - obj_fcn(i-1)) < e, break; end,
	end
end

iter_n = i;	
obj_fcn(iter_n+1:max_iter) = [];
