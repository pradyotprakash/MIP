function [ biasRemovedImage,residualImage,bias, objfun, initMemberships, finalMemberships] = iterate(inputData,mask,weight,iterations,q)
%ITERATE Iterates over image and performs modifed fuzzy c means
[xdim,ydim] = size(inputData);

bias = 1*ones(xdim,ydim);
% means = [0.0, 0.6362 ,0.9521];

[~, means] = kmeans(reshape(inputData.*mask, [xdim*ydim, 1]), 3);

means = means'

% weight(6,6) = 0;
% weight = weight/sum(sum(weight))

runningImage = inputData;
[membership,d] = findMembership(runningImage,mask,means,bias,weight,q);

initMemberships = membership;

objfun = [];

for i = 1:iterations
	[membership,d] = findMembership(runningImage,mask,means,bias,weight,q);
	means = findMeans(runningImage,mask,membership,bias,weight,q);
	bias = findBias(runningImage,mask,membership,means,weight,q);

	temp=zeros(xdim,ydim);
	for i=1:3
	    temp = (temp + (membership(:,:,i).^q).*d(:,:,i)).*mask;
	end
	objective = sum(sum(temp))
	objfun = [objfun objective];
end

biasRemovedImage = zeros(xdim,ydim);
for i = 1:3
	biasRemovedImage = biasRemovedImage+membership(:,:,i).*means(i);

finalMemberships = membership;
residualImage = mask.*(inputData-biasRemovedImage.*bias);
biasRemovedImage = biasRemovedImage.*mask;
means
% residualImage = bias;
end

