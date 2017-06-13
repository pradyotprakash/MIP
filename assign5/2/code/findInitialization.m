function [initialization] = findInitialization(img, mask, numClasses)

	% Initial estimate is through the k-means algorithm. We look at all
	% the pixel values inside the mask and performed k-means with 3 classes
	% on the pixels inside the pixel. The inside pixels had the 3 labels
	% 1, 2, 3 and the outside had labels 0. This seemed like a coarse
	% initialization and the EM will correct the segmentations.

	U = zeros(sum(mask(:)), 1);
	initialization = zeros(size(img));

	count = 0;
	for i = 1:size(img, 1)
		for j = 1:size(img, 2)

			if mask(i, j) == 1
				count = count + 1;
				U(count) = img(i, j);
			end
		end
	end

	labs = kmeans(U, numClasses);

	count = 0;
	for i = 1:size(img, 1)
		for j = 1:size(img, 2)

			if mask(i, j) == 1
				count = count + 1;
				initialization(i, j) = labs(count);
			end
		end
	end	

end