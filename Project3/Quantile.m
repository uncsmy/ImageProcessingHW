function distance = Quantile(A,B,l)

a = 64+l;
b = 64-l;
c = 128 - 2*l;
d = 128;

intens_A = A(b:a,c:d);
intens_A = sort(intens_A(:));
[n,~] = size(intens_A);
intens_B = B(b:a,c:d);
intens_B = sort(intens_B(:));

distance = sum(abs(intens_A-intens_B))*(1/n);

end