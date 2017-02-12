tic;

%% 
load ../data/myPhantom;

findMinTheta;

figure;
plot(errors);
title('RRMSE vs Theta')
xlabel('Theta')
ylabel('RRMSE')

figure;
subplot(1, 2, 1);
imagesc(imageAC);
title('Original Phantom Image')
colormap(gray);
axis square;
colorbar;
subplot(1, 2, 2);
angles = minTheta:minTheta+150;
t = radon(imageAC, angles);
y = iradon(t, angles, 'linear', 'Ram-Lak', size(imageAC, 1));
imagesc(y);
axis square;
colorbar;
title('Reconstructed Phantom Image');

load ../data/CT_Chest;

findMinTheta;

figure;
plot(errors);
title('RRMSE vs Theta')
xlabel('Theta')
ylabel('RRMSE')

figure;
subplot(1, 2, 1);
imagesc(imageAC);
title('Original Chest CT Image')
colormap(gray);
axis square;
colorbar;
subplot(1, 2, 2);
angles = minTheta:minTheta+150;
t = radon(imageAC, angles);
y = iradon(t, angles, 'linear', 'Ram-Lak', size(imageAC, 1));
imagesc(y);
axis square;
colorbar;
title('Reconstructed Chest CT Image');

toc;