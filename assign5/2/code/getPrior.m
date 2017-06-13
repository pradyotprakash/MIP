function [y] = getPrior(labels, label, i, j, mask, beta)

	count = 0;
	if mask(i - 1, j)
		count = count + (label ~= labels(i - 1, j));
	end

	if mask(i + 1, j)
		count = count + (label ~= labels(i + 1, j));
	end

	if mask(i, j - 1)
		count = count + (label ~= labels(i, j - 1));
	end

	if mask(i, j + 1)
		count = count + (label ~= labels(i, j + 1));
	end

	y = beta * double(count);

end