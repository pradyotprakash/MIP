function [mu_, sig_] = getMuAndSig(img, locations)

	% We have peformed maximum likelihood estimation on the various pixels within a particular class.

	numPoints = sum(locations(:));
	T = img .* locations;
	mu_ = sum(sum(T))/numPoints;
	sig_ = sqrt(sum(sum((T - mu_) .^ 2))/numPoints);

end