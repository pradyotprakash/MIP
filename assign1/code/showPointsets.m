function [] = showPointsets(P)

	figure;
	for i = 1:size(P, 3)
		Pi = P(:, :, i);
		plot(Pi(1, :), Pi(2, :), 'd', 'color', rand(1, 3));
		hold on;
		axis equal tight;
	end

end