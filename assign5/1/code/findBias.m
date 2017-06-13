function [ bias ] = findBias(image,mask,membership,means,weight,q )
%FINDBIAS Find estimated bias at every iteration

[dimx,dimy] = size(image);
[~,dimm] = size(means);
wtdMean = zeros(dimx,dimy);
wtdMean2 = zeros(dimx,dimy);

for i = 1:dimm
	wtdMean = wtdMean+(membership(:,:,i).^q)*means(i);
	wtdMean2 = wtdMean2+(membership(:,:,i).^q)*(means(i)*means(i));
end
bias = (conv2(image.*mask.*wtdMean,weight,'same'))./(conv2(wtdMean2,weight,'same'));
bias(isnan(bias))=0;
end

