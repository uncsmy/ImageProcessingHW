clc;clear all;close all;

Img = imread('1.bmp');

clusters =4;                               
m=2;                                        
iter_max=500;                               
e=1e-5;                                     
delta=10;                                   

init=KFCM_init(Img,clusters);              
Imgs=KFCM_Img(Img,init,clusters,m,iter_max,e,delta);


subplot(3,2,1); imshow(Imgs,[]);
for i=1:clusters
    subplot(3,2,i+1);
    imshow(Imgs==i);
end
