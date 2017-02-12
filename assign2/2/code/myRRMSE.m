function [rrmse] = myRRMSE(img1, img2)
	
	rrmse = norm(img1 - img2, 'fro') / norm(img1, 'fro');

end 