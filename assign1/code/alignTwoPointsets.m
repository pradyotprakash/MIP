function [P1, P2] = alignTwoPointsets(P1, P2)

	m1 = mean(P1, 2);
	P1 = bsxfun(@(x,y) x - y, P1, m1);
	P1 = P1/norm(P1, 'fro');

	m2 = mean(P2, 2);
	P2 = bsxfun(@(x,y) x - y, P2, m2);
	P2 = P2/norm(P2, 'fro');

	[U, S, V] = svd(P1 * P2');
	R = V * U';

	if abs(det(R) + 1) <= 1e-4
		for i = 1:size(V, 2)
			J = eye(size(V, 2));
			J(i, i) = -1;

			R = V * J * U';
			if abs(det(R) -1 ) <= 1e-4
				break;
			end
		end
	end

	P1 = R * P1;
end