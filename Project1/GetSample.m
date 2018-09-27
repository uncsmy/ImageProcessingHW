RGB = imread('test2.jpg');
im = rgb2gray(RGB);
imr = double(imresize(im,0.4));
imr1 = imr/255;
imshow(imr1,[0,1])


[m,n] = find(imr < 254);

d = 0;
for ii = n
    ind = find(n==ii);
    sub = m(ind,:);
    len = max(sub) - min(sub);
    if len > d
        d = len;
    end
end

[center,~] = HoughTransform1(imr1,d/2,-1,1.5,0.05,1,1)

