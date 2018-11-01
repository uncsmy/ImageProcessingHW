step = 0.01;
k =4;
mu = 0;
sigma = 2;
A = -500;
B = 1000;
local = -0.75/k;
l = 3;

target = ImageGeneration(sigma,k,0.25/k,A,B);

ccs = [];
mis = [];
ds = [];
i = 0;
angles = -pi:step:pi;

for angle = angles
    i = i+1;
    im = ImageGeneration(sigma,k,angle,1,0);
    cc = CrossCorr(im,target);
    mi = MutualInfo(im,target);
    d = Quantile(im,target,l);
    ccs(i) = cc;
    mis(i) = mi;
    ds(i) = d;
end

[cc_sort,cc_ind] = sort(ccs,'descend');
[mis_sort,mis_ind] = sort(mis,'descend');
[ds_sort,ds_ind] = sort(ds);

angle_cc_detected = -pi+cc_ind(1)*step;
angle_mi_detected = -pi+mis_ind(1)*step;
angle_ds_detected = -pi+ds_ind(1)*step;

im_local = ImageGeneration(sigma,k,local,A,B);
cc_local = CrossCorr(im_local,target);
mi_local = MutualInfo(im_local,target);
d_local = Quantile(im_local,target,l);

cc_lowering = -(cc_local - ccs(cc_ind(1)))/ccs(cc_ind(1));
mi_lowering = -(mi_local - mis(mis_ind(1)))/mis(mis_ind(1));
d_lowering = (d_local-ds(ds_ind(1)))/ds(ds_ind(1));

deri_cc_0 = (ccs(cc_ind(1)+1) - ccs(cc_ind(1)))/(step);
deri_cc_r = (ccs(cc_ind(1)+2) - ccs(cc_ind(1)+1))/(step);
deri_cc_l = (ccs(cc_ind(1)) - ccs(cc_ind(1)-1))/(step);
deri_cc_2 = -(deri_cc_r - deri_cc_l)/(2*step);

deri_mi_0 = (mis(mis_ind(1)+1) - mis(mis_ind(1)))/(step);
deri_mi_r = (mis(mis_ind(1)+2) - mis(mis_ind(1)+1))/(step);
deri_mi_l = (mis(mis_ind(1)) - mis(mis_ind(1)-1))/(step);
deri_mi_2 = -(deri_mi_r - deri_mi_l)/(2*step);

deri_ds_0 = (ds(ds_ind(1)+1) - ds(ds_ind(1)))/(step);
deri_ds_r = (ds(ds_ind(1)+2) - ds(ds_ind(1)+1))/(step);
deri_ds_l = (ds(ds_ind(1)) - ds(ds_ind(1)-1))/(step);
deri_ds_2 = -(deri_ds_r - deri_ds_l)/(2*step);



