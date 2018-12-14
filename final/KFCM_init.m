function [Vinit]=KFCM_init(Img,cluster_n)
Img=double(Img);
[row,col]=size(Img);
Imgtmp=reshape(Img,row*col,1);
[index,Vinit]=kmeans(Imgtmp,cluster_n,'emptyaction','singleton');
