function [y] = RRMSE(img1, img2)
	y = norm(abs(img1) - abs(img2), 'fro') / norm(abs(img1), 'fro');
end