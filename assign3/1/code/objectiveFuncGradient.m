function [y] = objectiveFuncGradient(noisyImage, estimatedImage, alpha, gamma, type)

	y = alpha * (estimatedImage - noisyImage);

	if type == 1
		y = y + (1 - alpha) * MRFQuadraticGradient(estimatedImage);
	elseif type == 2
		y = y + (1 - alpha) * MRFHuberGradient(estimatedImage, gamma);
	else
		y = y + (1 - alpha) * MRFDiscontinuityGradient(estimatedImage, gamma);
	end

	% y = sum(sum(y));
end