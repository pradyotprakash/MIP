function [y] = gaussianNoiseProb(estimatedImage, noisyImage, mask)
	% y = ((abs(noisyImage - estimatedImage)) .^ 2) / 2;
	% Noisy image is in kspace
	y = abs(noisyImage - mask.*fft2(estimatedImage)) .^ 2;
end
