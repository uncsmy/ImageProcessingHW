function Img_label=KFCM_Img(Img,Vinit,cluster_n,m,iter_max,e,delta)

if nargin==3
    m=2;iter_max=1000;e=1e-5;delta=10;
end
if nargin==4
    iter_max=1000;e=1e-5;delta=10;
end
if nargin==5
    e=1e-5;delta=10;
end
if nargin==6
    delta=10;
end
    
Img=double(Img);
[nrow,ncol]=size(Img);

Img_reshape=reshape(Img,nrow*ncol,1);       
options = [m;iter_max;e;1;delta]; 


[center,U,obj_fcn] = KFCM(Img_reshape,Vinit,options); 

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

