tic;
load ../data/assignmentImageReconstructionBrain.mat;

imageNoisy = imageKspaceData;
mask = imageKspaceMask;

imageNoiseless = ones(size(imageNoisy));

alpha = 0.001;
gamma = 0.0;
fprintf('Quadratic\n');
fprintf('Optimal alpha %d\n', alpha);
[noiselessImage1, err1,iterationVal1] = gradientDescent(imageNoiseless, imageNoisy, mask, alpha, gamma, 1);


alpha = 0.00015;
gamma = 0.25;
fprintf('Huber\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage2, err2,iterationVal2] = gradientDescent(imageNoiseless, imageNoisy, mask, alpha, gamma, 2);


alpha = 0.00002;
gamma = 0.05;
fprintf('Discontinuity-adaptive\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage3, err3,iterationVal3] = gradientDescent(imageNoiseless, imageNoisy, mask, alpha, gamma, 3);


minMap = 0;
maxMap = 1.2;


figure,imagesc(abs(ifft2(imageNoisy)),[minMap,maxMap]);
title('Noisy Image')
colormap(gray);
axis square;
colorbar;

figure,imagesc(abs(noiselessImage1),[minMap,maxMap]);
title('Denoised Image(Quadratic Prior)')
colormap(gray);
axis square;
colorbar;

figure,imagesc(abs(noiselessImage2),[minMap,maxMap]);
title('Denoised Image(Huber Prior)')
colormap(gray);
axis square;
colorbar;

figure,imagesc(abs(noiselessImage3),[minMap,maxMap]);
title('Denoised Image(Discontinuity-adaptive Prior)')
colormap(gray);
axis square;
colorbar;

figure,subplot(3,1,1),plot(iterationVal1);
title('Objective Function vs Iteration(Quadratic Prior)')
xlabel('Iterations')
ylabel('Objective Function')

subplot(3,1,2),plot(iterationVal2);
title('Objective Function vs Iteration(Huber Prior)')
xlabel('Iterations')
ylabel('Objective Function')

subplot(3,1,3),plot(iterationVal3);
title('Objective Function vs Iteration(Discontinuity-adaptive Prior)')
xlabel('Iterations')
ylabel('Objective Function')

% intialRRMSE = RRMSE(imageNoiseless, ifft2(imageNoisy))

% % initialGuess = ifft2(imageNoisy);
% type = 3;
% targetImage = imageNoiseless;

% % % % snippetfor finding optimal alpha and gamma values
% bestAlpha1 = 0;
% bestGamma1 = 0;
% bestErr1 = 1e10;
% errors = zeros(11,11);
% i=0;
% for alpha = 0.000007
%     i=i+1;
%     j=0;
% 	for gamma = 0.0:0.01:0.1

%         j=j+1;
% 		fprintf('%d %d\n', alpha, gamma);
% 		[noiselessImage1, err1] = gradientDescent(imageNoiseless, imageNoisy, mask, alpha, gamma, type);
% 		err1
%         errors(i,j) = min(1.0,err1);
% 		if err1 < bestErr1
% 			bestErr1 = err1
% 			bestAlpha1 = alpha;
% 			bestGamma1 = gamma;
% 		end
% 	end
% end
% errors
% toc;
