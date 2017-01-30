function [z, P] = findMeanShape(P)

	z = P(:, :, 1);
	
	while true
		newZ = zeros(size(z));
		newP = zeros(size(P));

		for i = 1:size(P, 3)
			Pi = P(:, :, i);
			Pi = alignTwoPointsets(Pi, z);
			newP(:, :, i) = Pi;
			newZ = newZ + Pi;
		end

		z1 = newZ/norm(newZ, 'fro');

		if norm(z - z1, 'fro')/norm(z, 'fro') < 1e-2
			break;
		end

		z = z1;
		P = newP;
	end
end