[X,Y] = meshgrid(1:128,1:128); % imgae coordinate
cos_v = (X-64.5)./ sqrt((X-64.5).^2 + (Y-64.5).^2);

theta = acos(cos_v)*(180/pi);
c = cos(2*pi*4*(theta));