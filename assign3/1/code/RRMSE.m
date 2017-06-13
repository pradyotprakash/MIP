function [y] = RRMSE(img1, img2)
	y = norm(img1 - img2, 'fro') / norm(img1, 'fro');
end