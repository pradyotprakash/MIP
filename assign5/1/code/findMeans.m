function [ means ] = findMeans( image,mask,membership,bias,weight,q )
%FINDMEANS Find estimated class mean at every iteration

biasConv = conv2(bias.*mask,weight,'same');
bias2Conv = conv2(bias.*bias.*mask,weight,'same');
[~,~,dimm] = size(membership);
means = zeros(1,dimm);
for i = 1:dimm
	means(i) = sum(sum(((membership(:,:,i).^(q)).*image.*mask.*(biasConv))))/sum(sum(((membership(:,:,i).^(q)).*(bias2Conv))));
end
end

