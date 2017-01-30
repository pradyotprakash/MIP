tic;

load ../data/bone3D.mat
bone = shapesTotal;

showPointsets3d(bone);
[z, P] = findMeanShape(bone);

showPointsets3d(P);
patch('Vertices', z', 'Faces', TriangleIndex, 'FaceColor', 'green', 'Edgecolor', 'red');
view(3);
axis vis3d;

[V, D] = findShapeVariations3d(z, P, TriangleIndex);

figure;
plot(1:size(D, 1), D);


toc;