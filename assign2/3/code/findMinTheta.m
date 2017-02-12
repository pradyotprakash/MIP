minError = 1e10;
minTheta = 0;
errors = [];
theta = 0;
h = waitbar(theta, 'Iterating over thetas');

for theta = 0:180
	angles = theta:theta+150;

	t = radon(imageAC, angles);
	y = iradon(t, angles, 'linear', 'Ram-Lak', size(imageAC, 1));

	err = norm(imageAC - y, 'fro')/norm(imageAC, 'fro');
	errors = [errors, err];

	if err < minError
		minError = err;
		minTheta = theta;
	end

	waitbar(double(theta/180));
end

close(h);