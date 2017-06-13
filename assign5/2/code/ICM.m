function [labels] = ICM(img, mask, labels, numClasses, mu, sig, beta)


	% assume convergence in 10 iterations
	for jj = 1:10

		newLabels = zeros(size(img));
		sumLog = 0;
		oldSumLog = 0;
		for i = 2:size(img, 1) - 1
			for j = 2:size(img, 2) - 1
				
				if mask(i, j) == 0
					continue;
				end

				oldPrior = getPrior(labels, labels(i, j), i, j, mask, beta);
				oldLikelihood = getLikelihood(img, i, j, labels(i, j), mu, sig);
				oldSumLog = oldSumLog + oldPrior + oldLikelihood;

				probVals = [];
				for label = 1:numClasses
					prior = getPrior(labels, label, i, j, mask, beta);
					likelihood = getLikelihood(img, i, j, label, mu, sig);
					probVals = [probVals, prior + likelihood];
					sumLog = sumLog + prior + likelihood;
				end

				[~, ind] = min(probVals);
				newLabels(i, j) = ind;
			end
		end

		labels = newLabels;

	end

	fprintf('Change in log posterior: %f to %f\n', oldSumLog, sumLog);

end