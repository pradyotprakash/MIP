function [noiselessImage, err, iterationObj] = gradientDescent(targetImage, initialGuess, mask, alpha, gamma, type)

	% initialGuess = ifft2(initialGuess);
	noiselessImage = ifft2(initialGuess);
	% tau = 1e-1*ones(size(initialGuess));
	tau = 1e-1;

	count = 0;
    MaxIter=150;
    iterationObj=[sum(sum(objectiveFunc(initialGuess, noiselessImage, mask, alpha, gamma, type)))];
	% objectiveFuncGradient(initialGuess, noiselessImage, mask, alpha, gamma, type)
	while true
		count = count + 1;
		% tau
		noiselessImageNew = noiselessImage - tau * objectiveFuncGradient(initialGuess, noiselessImage, mask, alpha, gamma, type);

		oldVal = objectiveFunc(initialGuess, noiselessImage, mask, alpha, gamma, type);
		newVal = objectiveFunc(initialGuess, noiselessImageNew, mask, alpha, gamma, type);

		% temp1 = sum(oldVal(:))
		% temp2 = sum(newVal(:))
        
		% break;

        % fprintf('newval - oldval = %d \n', norm(newVal - oldVal, 'fro')/norm(oldVal, 'fro'));
		if norm(newVal - oldVal, 'fro')/norm(oldVal, 'fro') < 1e-5
			break;
        end
        
        if count >MaxIter
            break;
        end

		if sum(oldVal(:)) < sum(newVal(:))
			tau = 0.5*tau;
			continue;
		end

		tau = 1.1*tau;

        iterationObj(end+1) = sum(sum(newVal));

		% norm(newVal - oldVal, 'fro')/norm(oldVal, 'fro')


		noiselessImage = noiselessImageNew;

		% T = abs(newVal) <= abs(oldVal);
		% tau = ((1.1*tau) .* T) + ((0.5*tau) .* (~T));
	end

	err = RRMSE(targetImage, noiselessImage);
end