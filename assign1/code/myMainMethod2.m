tic;

load ../data/ellipses2D
ellipses = pointSets;

showPointsets(ellipses);
[z, P] = findMeanShape(ellipses);

showPointsets(P);
plot(z(1, :), z(2, :));

[V, D] = findShapeVariations(z, P);

figure;
plot(1:size(D, 1), D);


toc;