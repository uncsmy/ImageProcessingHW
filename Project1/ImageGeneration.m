function im = ImageGeneration(n, imageX, imageY, ...
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
im = imgaussfilt(im,blur);
end

if sigma > 0
im = imnoise(im,'gaussian',mean,sigma);
end

end

