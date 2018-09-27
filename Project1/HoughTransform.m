function [center,gradmode] = HoughTransform(img,r,polar,pstd,thred,scale,n)

[imageX,imageY] = size(img);
[imgderx,imgdery] = Derivative(img,scale);
gradmode = sqrt(imgderx.^2 + imgdery.^2);
imgderx_unit = imgderx./gradmode;
imgdery_unit = imgdery./gradmode;
[edgerow,edgecol] = find(gradmode > thred);
edgepoints = [edgerow,edgecol];
[nrow,~] = size(edgepoints);

if nrow > 0
    for k = 1:nrow
        a = edgerow(k);
        b = edgecol(k);
        voteX = imageX - fix(imageX-a + polar*r*imgdery_unit(a,b));
        voteY = fix(b + polar*r*imgderx_unit(a,b));
        voteM(k,1) = voteX;
        voteM(k,2) = voteY;
        voteM(k,3) = gradmode(a,b);
    end

    mu = mean(voteM(:,3));
    sigma = sqrt(var(voteM(:,3)));
    voteM(:,4) = normcdf(voteM(:,3),mu,sigma);

    stat = zeros(imageX,imageY);
    for ii = 1:nrow
        a = int8(voteM(ii,1));
        b = int8(voteM(ii,2));
        c = voteM(ii,4);
        if a > 0 && a < (imageX+1) && b > 0 && b < (imageY+1)
            stat(a,b) = stat(a,b) + c;
        end
    end

    temp = stat;
    center = [];

    for jj = 1:n
        temp_s = imgaussfilt(temp,pstd);
        [centerX,centerY] = find(temp_s==max(temp_s(:)));
        center(jj,1) = centerX;
        center(jj,2) = centerY;
        temp(centerX,centerY) = 0; 
    end

else
    center = [0,0];

end
%stat1 = imgaussfilt(stat,pstd);
%[centerX,centerY] = find(stat1 == max(stat1(:)));
end