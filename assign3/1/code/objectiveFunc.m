function [y] = objectiveFunc(noisyImage, estimatedImage, alpha, gamma, type)

	y = alpha * gaussianNoiseProb(estimatedImage, noisyImage);

	if type == 1
		y = y + (1 - alpha) * MRFQuadratic(estimatedImage);
	elseif type == 2
		y = y + (1 - alpha) * MRFHuber(estimatedImage, gamma);
	elseif type == 3
		y = y + (1 - alpha) * MRFDiscontinuity(estimatedImage, gamma);
	end

	% y = sum(sum(y));
end