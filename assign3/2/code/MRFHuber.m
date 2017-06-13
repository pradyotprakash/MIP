function [y] = MRFHuber(img, gamma)
	U = getAbsU(img);
	y = zeros(size(img));

	for i = 1:4
		modU = U(:, :, i);
		T = (modU <= gamma);
		V = (T .* (0.5 * (modU .^ 2))) + ((~T) .* (gamma*modU - 0.5*gamma^2));
		y = y + V;
	end

end