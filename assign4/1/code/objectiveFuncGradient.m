function [y] = objectiveFuncGradient(noisyImage, estimatedImage, mask, alpha, gamma, type)

	% y = alpha * (estimatedImage - noisyImage);
	% sz = size(noisyImage);
	% temp = mask(:);
	% maskMat = zeros(sum(temp), size(temp,1));
	% temp = find(temp);
	% temp1 = (0:(size(temp)-1))';
	% temp = temp + temp1*size(maskMat,2);
	% maskMat(temp) = 1;
	% maskConj = maskMat'; % finds indices of mask

	y = alpha * (ifft2( (mask .* fft2(estimatedImage))) - ifft2( mask .* noisyImage));

	if type == 1
		y = y + (1 - alpha) * MRFQuadraticGradient(estimatedImage);
	elseif type == 2
		y = y + (1 - alpha) * MRFHuberGradient(estimatedImage, gamma);
	else
		y = y + (1 - alpha) * MRFDiscontinuityGradient(estimatedImage, gamma);
	end

	% y = sum(sum(y));
end