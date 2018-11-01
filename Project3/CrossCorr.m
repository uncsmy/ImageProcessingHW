function cc = CrossCorr(A,B)

A_mean = mean2(A);
B_mean = mean2(B);
A_len = sqrt(sum(sum((A-A_mean).^2)));
B_len = sqrt(sum(sum((B-B_mean).^2)));
cc = sum(sum((A-A_mean).*(B-B_mean)))/(A_len*B_len);

end