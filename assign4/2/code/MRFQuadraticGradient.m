function [y] = MRFQuadraticGradient(img)

	U = getU(img);
	y = zeros(size(img));
	for i = 1:4
		y = y + 2*U(:, :, i);
	end
end