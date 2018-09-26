function [im,im_blur,im_noise] = ImageGeneration(n, imageX, imageY, ...
centerX,centerY,r,intensity,blur,mean,sigma)

[columns, rows] = meshgrid(1:imageY,1:imageX);

im = ones(imageX,imageY);
for ii = 1:n
    circle = (rows - centerX(ii)).^2 + (columns - centerY(ii)).^2 <= r^2;
    im_temp = ones(imageX, imageY);
    im_temp(circle) = intensity(ii);
    im = min(im,im_temp);
end

if blur > 0
im_blur = imgaussfilt(im,blur);
else
im_blur = [];
end

if sigma > 0
im_noise = imnoise(im,'gaussian',mean,sigma);
else
im_noise = [];
end

end

