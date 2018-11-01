function image = ImageGeneration(sigma,k,angle,A,B)

[X,Y] = meshgrid(1:128,1:128); % imgae coordinate
cos_v = (X-64.5)./ sqrt((X-64.5).^2 + (Y-64.5).^2);
theta = acos(cos_v);
theta(1:64,:) = theta(1:64,:) - angle;
theta(65:128,:) = theta(65:128,:) + angle;
c = cos(2*pi*k*(theta));
image = (1./(1+abs(theta)).^2).* c;
image = A*image + B;

image = imgaussfilt(image,sigma); % gaussian blurring

end