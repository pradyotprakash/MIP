function [noiselessImage, err,iterationObj] = gradientDescent(targetImage, initialGuess, alpha, gamma, type)

	noiselessImage = initialGuess;
	tau = 1e-1*ones(size(initialGuess));

	count = 0;
    MaxIter=150;
    iterationObj=[sum(sum(objectiveFunc(initialGuess, noiselessImage, alpha, gamma, type)))];
	while true
		count = count + 1;
		noiselessImageNew = noiselessImage - tau .* objectiveFuncGradient(initialGuess, noiselessImage, alpha, gamma, type);

		oldVal = objectiveFunc(initialGuess, noiselessImage, alpha, gamma, type);
		newVal = objectiveFunc(initialGuess, noiselessImageNew, alpha, gamma, type);
        iterationObj(end+1) = sum(sum(newVal));

		% norm(newVal - oldVal, 'fro')/norm(oldVal, 'fro')

		if norm(newVal - oldVal, 'fro')/norm(oldVal, 'fro') < 1e-3
			break;
        end
        
        if count >MaxIter
            break;
        end

		noiselessImage = noiselessImageNew;

		T = abs(newVal) <= abs(oldVal);
		tau = ((1.1*tau) .* T) + ((0.5*tau) .* (~T));
		
	err = RRMSE(targetImage, noiselessImage);
	end
	err = RRMSE(targetImage, noiselessImage);
end