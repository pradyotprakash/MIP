tic;
%% (A) Radon transform and Inverse Radon with filter
phant = phantom(256);

x=linspace(-128,128,256);
y=linspace(-128,128,256);
figure,subplot(1,3,1),imagesc(x,y,phant);
title('Original Image')
colormap(gray);
axis square;
colorbar;

% computing radon transform
angles = 0:3:177;
radTrans = radon(phant,angles);
subplot(1,3,2),imagesc(x,y,radTrans);
title('Radon Transform')
colormap(gray);
axis square;
colorbar;
% computing backprojection
iradTrans = iradon(radTrans,angles);
subplot(1,3,3),imagesc(x,y,iradTrans);
title('Backprojection')
colormap(gray);
axis square;
colorbar;


%% (A) Radon transform on blurred images
phant = phantom(256);
phant1 = conv2(phant, fspecial ('gaussian', 11, 1),'same');
phant5 = conv2(phant, fspecial ('gaussian', 51, 5),'same');

x=linspace(-128,128,256);
y=linspace(-128,128,256);
figure,subplot(1,3,1),imagesc(x,y,phant);
title('Original Image')
colormap(gray);
axis square;
colorbar;
subplot(1,3,2),imagesc(x,y,phant1);
title('Original Image')
colormap(gray);
axis square;
colorbar;
subplot(1,3,3),imagesc(x,y,phant5);
title('Original Image')
colormap(gray);
axis square;
colorbar;

toc;

