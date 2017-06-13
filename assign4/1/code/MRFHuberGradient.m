function [y] = MRFHuberGradient(img, gamma)

	U = getU(img);
	y = zeros(size(img));

	for i = 1:4
		T = (U(:, :, i) <= gamma);
		V = (T .* U(:, :, i)) + ((~T) .* (gamma*sign(U(:, :, i))));
		y = y + V;
	end

end