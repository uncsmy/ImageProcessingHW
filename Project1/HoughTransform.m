function [center,gradmode] = HoughTransform(img,r,thred,scale,k)

[imageX,imageY] = size(img);
[imgderx,imgdery] = Derivative(img,scale);
gradmode = sqrt(imgderx.^2 + imgdery.^2);
[edgerow,edgecol] = find(gradmode > thred);
edgepoints = [edgerow,edgecol];
[nrow,~] = size(edgepoints);
stat = [];
num = 0;

for ii = 1:nrow
   a = edgepoints(ii,1); %row
   b = edgepoints(ii,2); %col
   
   if a - r > 0
       start = a-r;
   else
       start = 1;
   end
   
   if a + r <= imageX
       endd = a+r;
   else
       endd = imageX;
   end
   
   for jj = start:endd
       d = fix(sqrt(r^2-(jj-a)^2));
       if b - d > 0
           num = num + 1;
           stat(num,1) = jj;
           stat(num,2) = b -d;
       end
       
       if b + d <= imageY
           num = num + 1;
           stat(num,1) = jj;
           stat(num,2) = b + d;
       end
   end
[ustat,~,n] = unique(stat,'rows');
[~,ind] = maxk(accumarray(n,1),k);
center = ustat(ind,:);
end


