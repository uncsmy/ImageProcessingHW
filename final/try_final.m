Img = imread('1.bmp');

cluster_n =4;                               
m=2;                                        
iter_max=500;                               
e=1e-5;                                     
delta=10; 

Img=double(Img);
[nrow,ncol]=size(Img);
Img_reshape=reshape(Img,nrow*ncol,1);

Vinit=KFCM_init(Img,cluster_n);
options = [m;iter_max;e;1;delta];
[center,U,obj_fcn] = kfcm(Img_reshape,Vinit,options);
maxU = max(U);
maxUn=repmat(maxU,cluster_n,1);
U=U';
maxUn=maxUn';
One_index=(maxUn==U);

Img_label=zeros(size(Img_reshape));
for i=1:cluster_n
    index=floor(find(One_index(:,i)==1));
    Img_label(index)=i;
end

Img_label=reshape(Img_label,nrow,ncol);

