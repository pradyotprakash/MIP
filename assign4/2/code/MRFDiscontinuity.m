function [y] = MRFDiscontinuity(img, gamma)

	U = getAbsU(img);
	y = zeros(size(img));

	for i = 1:4
		modU = U(:, :, i);
		V = gamma*modU - (gamma^2) * log(1 + modU/gamma);
		y = y + V;
	end

end