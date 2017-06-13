tic;
load ../data/assignmentImageDenoisingBrainNoisy.mat;

backGr = imageNoisy(1:50, 1:50);
realNoiseLevel = sqrt(var(real(backGr(:))));
imagNoiseLevel = sqrt(var(imag(backGr(:))));

fprintf('Real Noise Level (found from pixels in imageNoisy(1:50, 1:50)) : %f \n', realNoiseLevel);
fprintf('Imaginary Noise Level (found from pixels in imageNoisy(1:50, 1:50)) : %f \n', imagNoiseLevel);

minMap = 0;
maxMap = 1.2;

figure,imagesc(abs(imageNoisy),[minMap,maxMap]);
title('Noisy Image')
colormap(gray);
axis square;
colorbar;




alpha = 0.8;
gamma = 0.0;
fprintf('Quadratic\n');
fprintf('Optimal alpha %d\n', alpha);
[noiselessImage1,iterationVal1] = gradientDescent(imageNoisy, alpha, gamma, 1);
figure,imagesc(abs(noiselessImage1),[minMap,maxMap]);
title('Denoised Image (Quadratic prior)')
colormap(gray);
axis square;
colorbar;


alpha = 0.503;
gamma = 0.0424;
fprintf('Huber\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage2,iterationVal2] = gradientDescent(imageNoisy, alpha, gamma, 2);

figure,imagesc(abs(noiselessImage2),[minMap,maxMap]);
title('Denoised image(Huber Prior)')
colormap(gray);
axis square;
colorbar;

alpha = 0.5;
gamma = 0.23;
fprintf('Discontinuity-adaptive\n');
fprintf('Optimal alpha, gamma %d %d\n', alpha, gamma);
[noiselessImage3,iterationVal3] = gradientDescent(imageNoisy, alpha, gamma, 3);

figure,imagesc(abs(noiselessImage3),[minMap,maxMap]);
title('Denoised image (Discontinuity-adaptive Prior)')
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

toc;
