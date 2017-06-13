function [labels, memberships] = EM(img, mask, labels, numClasses, mu, sig, beta)

	memberships = zeros(size(img, 1), size(img, 2), numClasses);

	% assume convergence in 10 iterations
	for jj = 1:10

		labels = ICM(img, mask, labels, numClasses, mu, sig, beta);

		for i = 2:size(img, 1) - 1
			for j = 2:size(img, 2) - 1

				if mask(i, j) == 0
					continue;
				end

				membership = zeros(numClasses, 1);
				for label = 1:numClasses
					prior = getPrior(labels, label, i, j, mask, beta);
					likelihood = getLikelihood(img, i, j, label, mu, sig);

					membership(label) = exp(-prior) * exp(-likelihood);
				end

				membership = membership/sum(membership);
				memberships(i, j, :) = membership;

			end
		end

		for label = 1:numClasses
			a = sum(sum(memberships(:, :, label)));
			b = sum(sum(memberships(:, :, label) .* img));

			mu(label) = b/a;

			c = sum(sum(memberships(:, :, label) .* ((img - mu(label)).^2)));
			sig(label) = sqrt(c/a);
		end
	end
end