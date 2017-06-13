function [y] = MRFQuadratic(img)
	U = getAbsU(img);
	y = zeros(size(img));

	for i = 1:4
		y = y + U(:, :, i) .^ 2;
	end

end