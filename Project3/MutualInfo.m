function MI = MutualInfo(A,B)

% joint pdf
histq = zeros(256,256);
[nrows,ncols] = size(A);

ma = min(A(:));
MA = max(A(:));
mb = min(B(:));
MB = max(B(:));

A = round((A-ma)*255/(MA-ma+eps)+1);
B = round((B-mb)*255/(MB-mb+eps)+1);

for i = 1:nrows
    for j = 1:ncols
        x = A(i,j);
        y = B(i,j);
        histq(x,y) = histq(x,y) + 1;
    end
end

histq = histq/sum(sum(histq));
ent_joint = -sum(sum(histq.*log(histq+eps)));
MI = entropy(A) + entropy(B) - ent_joint;
end