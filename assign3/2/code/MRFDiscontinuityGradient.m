function [y] = MRFDiscontinuityGradient(img, gamma)
	U = getU(img);
	y = zeros(size(img));

	for i = 1:4
		y = y + (gamma*U(:, :, i)) ./ (gamma + abs(U(:, :, i)));
	end

end