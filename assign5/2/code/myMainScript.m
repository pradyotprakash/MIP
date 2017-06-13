load ../data/assignmentSegmentBrainGmmEmMrf.mat;

img = imageData;
mask = imageMask;
numClasses = 3;

initialLabels = findInitialization(img, mask, numClasses);
labels = initialLabels;

mu = zeros(1, numClasses);
sig = zeros(1, numClasses);

for label = 1:numClasses
	locationsWithLabel = (labels == label);
	[mu_, sig_] = getMuAndSig(img, locationsWithLabel);
	mu(label) = mu_;
	sig(label) = sig_;
end

initialMu = mu;
initialSig = sig;

beta = 100.0;
fprintf('With beta: %f\n', beta);
[optimalLabels, optimalMemberships] = EM(img, mask, labels, numClasses, mu, sig, beta);
fprintf('Initial mu: %f, %f, %f\n', initialMu(1), initialMu(2), initialMu(3));
fprintf('Initial sig: %f, %f, %f\n', initialSig(1), initialSig(2), initialSig(3));
fprintf('Final mu: %f, %f, %f\n', mu(1), mu(2), mu(3));

figure, imshow(initialLabels, []), colorbar, title('Initial segmentation');
figure, imshow(img, []), colorbar, title('Corrupted image provided');
figure, imshow(optimalMemberships(:, :, 1), []), colorbar, title(strcat('Label 1 for beta = ', num2str(beta)));
figure, imshow(optimalMemberships(:, :, 2), []), colorbar, title(strcat('Label 2 for beta = ', num2str(beta)));
figure, imshow(optimalMemberships(:, :, 3), []), colorbar, title(strcat('Label 3 for beta = ', num2str(beta)));
figure, imshow(optimalLabels, []), colorbar, title(strcat('Optimal labels for beta = ', num2str(beta)));


beta = 0.0;
fprintf('With beta: %f\n', beta);
[optimalLabels, optimalMemberships] = EM(img, mask, labels, numClasses, mu, sig, beta);
fprintf('Final mu: %f, %f, %f\n', mu(1), mu(2), mu(3));

figure, imshow(optimalMemberships(:, :, 1), []), colorbar, title(strcat('Label 1 for beta = ', num2str(beta)));
figure, imshow(optimalMemberships(:, :, 2), []), colorbar, title(strcat('Label 2 for beta = ', num2str(beta)));
figure, imshow(optimalMemberships(:, :, 3), []), colorbar, title(strcat('Label 3 for beta = ', num2str(beta)));
figure, imshow(optimalLabels, []), colorbar, title(strcat('Optimal labels for beta = ', num2str(beta)));