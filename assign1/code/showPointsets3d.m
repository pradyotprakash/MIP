function [] = showPointsets3d(P)

	figure;
	for i = 1:size(P, 3)
		Pi = P(:, :, i);
		scatter3(Pi(1, :), Pi(2, :), Pi(3, :), 1, rand(1, 3));
		hold on;
		axis equal tight;
	end

end