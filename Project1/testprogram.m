imageX = 200;
imageY = 200;
r = 40;
r1 = 30;
[rows, columns] = meshgrid(1:imageX,1:imageY);
centerX = 40;
centerY = 40;
circle = (rows - centerX).^2 + (columns - centerY).^2 > r^2
centerX1 = 130;
centerY1 = 130;
circle1 = (rows - centerX1).^2 + (columns - centerY1).^2 > r1^2
im = min(circle, circle1)
%im = mat2gray(im)
imshow(im,[0,1])


