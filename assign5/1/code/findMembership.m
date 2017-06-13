function [ membership,d ] = findMembership( image,mask,means,bias,weight,q)
%FINDMEMBERSHIP given image, mask, weights and estimates of means and bias
% finds membership estimates

%dkj is a size(image)*size(means) sized tensor
[dimx,dimy] = size(image);
image = image.*mask;
[~,dimm] = size(means);
dkj = zeros(dimx,dimy,dimm);


for i = 1:dimm
	dkj(:,:,i) = image.^2+(means(i)^2)*conv2((bias.*mask).^2,weight,'same')-2*means(i)*(image.*conv2(bias.*mask,weight,'same'));
end


DD = dkj(dkj<0);
dkj(dkj<=0) = 1e-5;
dkj = (dkj).^(1/(1-q));

dkj(isnan(dkj))=0;
dkj(isinf(dkj))=0;

d = dkj;

membership = zeros(dimx,dimy,dimm);

for i = 1:dimm
	membership(:,:,i) = dkj(:,:,i)./sum(dkj,3);
end
membership(isnan(membership))=0;
membership(128,128,:);
end

