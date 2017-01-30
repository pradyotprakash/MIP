tic;

load ../data/hands2D
hands = shapes;

showPointsets(hands);
[z, P] = findMeanShape(hands);

showPointsets(P);
plot(z(1, :), z(2, :));

[V, D] = findShapeVariations(z, P);

figure;
plot(1:size(D, 1), D);


toc;