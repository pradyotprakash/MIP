%% Assignment 1 - Shape Analysis
%% 
% *Question 1*
fprintf('Following is the order of images below: \n');

tic;

load ../data/hands2D
hands = shapes;

fprintf('a) Plot of all pointsets \n');
showPointsets(hands);
[z, P] = findMeanShape(hands);

fprintf('b) Plot of computed shape mean along with aligned pointsets \n');
showPointsets(P);
plot(z(1, :), z(2, :));

fprintf('d) Top 3 principal modes of variations (highest eigenvalue to lowest from left to right) \n');
fprintf('From left to right : mean + 2 * std dev ; mean ; mean - 2 * std dev \n');
[V, D] = findShapeVariations(z, P);

fprintf('c) Plot of variances along principal modes of variation \n');
figure;
plot(1:size(D, 1), D);


toc;