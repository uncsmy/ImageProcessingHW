n=2;
imageX = 64;
imageY = 64;
centerX = [20,30];
centerY = [20,40];
r = 10;
intensity = [0.8,0.8];
img = ImageGeneration(n, imageX, imageY, ...
centerX,centerY,r,intensity,0,0,0);

polar=-1;
pstd=1;
thred=0.05;
scale = 1;
center = HoughTransform1(img,r,polar,pstd,thred,scale,n)

