function img = DrawEffect(im,r,centerX,centerY)
img = im;
[imX,imY] = size(im);
[columns, rows] = meshgrid(1:imY,1:imX);
circle = (rows - centerX).^2 + (columns - centerY).^2 <= r^2;
img(circle) = 0;
end