function [V, D] = findShapeVariations(z, P)

	X = zeros(size(P, 1) * size(P, 2), size(P, 3));
	reshape_size = size(z);

	for i = 1:size(P, 3)
		Pi = P(:, :, i);
		x = Pi - z;
		X(:, i) = x(:);
	end

	C = (X*X')/size(P, 3);
	[V, D] = eig(C);
	[V, D] = sortEigenVectors(V, D);
	for i = 1:3
		g1 = z + reshape(2*sqrt(D(i))*V(:, i), reshape_size);
		g2 = z - reshape(2*sqrt(D(i))*V(:, i), reshape_size);
		figure;
		subplot(1, 3, 1);
		plot(g1(1, :), g1(2, :));
		axis equal tight;
		subplot(1, 3, 2);
		plot(z(1, :), z(2, :));
		axis equal tight;
		subplot(1, 3, 3);
		plot(g2(1, :), g2(2, :));
		axis equal tight;
	end
end