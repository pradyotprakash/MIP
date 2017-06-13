function [y] = getLikelihood(img, i, j, label, mu, sig)
	% perhaps add multiplication by 1 - beta?
	y = (img(i, j) - mu(label))^2/(2*sig(label)^2);
end