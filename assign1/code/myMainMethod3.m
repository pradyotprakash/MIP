%% Assignment 1 - Shape Analysis
%% 
% *Question 3*
fprintf('Following is the order of images below: \n');

tic;

load ../data/bone3D.mat
bone = shapesTotal;

fprintf('a) Plot of all pointsets \n');
showPointsets3d(bone);
[z, P] = findMeanShape(bone);

fprintf('b) Plot of computed shape mean along with aligned pointsets \n');
showPointsets3d(P);
patch('Vertices', z', 'Faces', TriangleIndex, 'FaceColor', 'green', 'Edgecolor', 'red');
view(3);
axis vis3d;

fprintf('d) Top 3 principal modes of variations (highest eigenvalue to lowest) \n');
fprintf('From left to right : mean + 2 * std dev ; mean ; mean - 2 * std dev \n');
[V, D] = findShapeVariations3d(z, P, TriangleIndex);

fprintf('c) Plot of variances along principal modes of variation \n');
figure;
plot(1:size(D, 1), D);


toc;