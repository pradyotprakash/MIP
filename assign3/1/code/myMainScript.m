tic;
load ../data/assignmentImageDenoisingPhantom.mat;

alpha = 0.8;
gamma = 0.0;
fprintf('Quadratic\n');
fprintf('Optimal alpha %d\n', alpha);
[noiselessImage1, err1,iterationVal1] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma, 1);
[~, err1_a1y0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*0.8, gamma, 1);
[~, err1_ary0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*1.2, gamma, 1);
fprintf('RRMSE %d\n', err1);
fprintf('RRMSE at 0.8*alpha %d\n', err1_a1y0);
fprintf('RRMSE at 1.2*alpha %d\n', err1_ary0);


alpha = 0.503;
gamma = 0.0424;
fprintf('Huber\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage2, err2,iterationVal2] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma, 2);
[~, err2_a1y0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*0.8, gamma, 2);
[~, err2_ary0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*1.2, gamma, 2);
[~, err2_a0yl,~] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma*0.8, 2);
[~, err2_a0yr,~] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma*1.2, 2);
fprintf('RRMSE %d\n', err2);
fprintf('RRMSE at 0.8*alpha, gamma %d\n', err2_a1y0);
fprintf('RRMSE at 1.2*alpha, gamma %d\n', err2_ary0);
fprintf('RRMSE at alpha, 0.8*gamma %d\n', err2_a0yl);
fprintf('RRMSE at alpha, 1.2*gamma %d\n', err2_a0yr);

alpha = 0.005;
gamma = 0.0011;
fprintf('Discontinuity-adaptive\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage3, err3,iterationVal3] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma, 3);
[~, err3_a1y0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*0.8, gamma, 3);
[~, err3_ary0,~] = gradientDescent(imageNoiseless, imageNoisy, alpha*1.2, gamma, 3);
[~, err3_a0yl,~] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma*0.8, 3);
[~, err3_a0yr,~] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma*1.2, 3);
fprintf('RRMSE %d\n', err3);
fprintf('RRMSE at 0.8*alpha, gamma %d\n', err3_a1y0);
fprintf('RRMSE at 1.2*alpha, gamma %d\n', err3_ary0);
fprintf('RRMSE at alpha, 0.8*gamma %d\n', err3_a0yl);
fprintf('RRMSE at alpha, 1.2*gamma %d\n', err3_a0yr);

minMap = 0;
maxMap = 1.2;

figure,imagesc(abs(imageNoiseless),[minMap,maxMap]);
title('Noiseless Image')
colormap(gray);
axis square;
colorbar;

figure,imagesc(abs(imageNoisy),[minMap,maxMap]);
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

% initialGuess = imageNoisy;
% type = 2;
% targetImage = imageNoiseless;
% gradientDescent;

% snippetfor finding optimal alpha and gamma values
% bestAlpha1 = 0;
% bestGamma1 = 0;
% bestErr1 = 1e10;
% errors = zeros(11,11);
% i=0;
% for alpha = 0.5:0.02:0.7
%     i=i+1;
%     j=0;
% 	for gamma = 0.0:0.02:0.2
%         j=j+1;
% 		fprintf('%d %d\n', alpha, gamma);
% 		[noiselessImage1, err1] = gradientDescent(imageNoiseless, imageNoisy, alpha, gamma, 2);
%         errors(i,j) = min(1.0,err1);
% 		if err1 < bestErr1
% 			bestErr1 = err1
% 			bestAlpha1 = alpha;
% 			bestGamma1 = gamma;
% 		end
% 	end
% end
% errors
toc;
