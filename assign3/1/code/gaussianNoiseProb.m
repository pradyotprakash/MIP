function [y] = gaussianNoiseProb(estimatedImage, noisyImage)
	y = ((abs(noisyImage - estimatedImage)) .^ 2) / 2;
end
