function [y] = getU(img)

	y = zeros(size(img, 1), size(img, 2), 4);
	y(:, :, 1) = img - circshift(img, 1, 1);
	y(:, :, 2) = img - circshift(img, -1, 1);
	y(:, :, 3) = img - circshift(img, 1, 2);
	y(:, :, 4) = img - circshift(img, -1, 2);

end