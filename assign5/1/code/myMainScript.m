tic;
%Data
load ../data/assignmentSegmentBrain.mat;
weight = fspecial('gaussian', 15,7);
[biasRemovedImage,residualImage, bias, objfun, initMemberships, finalMemberships]= iterate(imageData,imageMask,weight,15,3);


figure,imshow(imageData);
title('Noisy Image')
colormap(gray);
axis square;
colorbar;

figure,imshow(biasRemovedImage);
title('Bias Removed Image')
colormap(gray);
axis square;
colorbar;

figure,imshow(abs(residualImage));
title('Residual Image')
colormap(gray);
axis square;
colorbar;

figure,imshow(bias);
title('Bias')
colormap(gray);
axis square;
colorbar;

figure, imshow(initMemberships(:,:,1));
title('Initial Membership : Class 1')
colormap(gray);
axis square;
colorbar;

figure, imshow(initMemberships(:,:,2));
title('Initial Membership : Class 2')
colormap(gray);
axis square;
colorbar;

figure,imshow(initMemberships(:,:,3));
title('Initial Membership : Class 3')
colormap(gray);
axis square;
colorbar;



figure,imshow(finalMemberships(:,:,1));
title('Final Membership : Class 1')
colormap(gray);
axis square;
colorbar;


figure,imshow(finalMemberships(:,:,2));
title('Final Membership : Class 2')
colormap(gray);
axis square;
colorbar;


figure,imshow(finalMemberships(:,:,3));
title('Final Membership : Class 3')
colormap(gray);
axis square;
colorbar;



figure,imagesc(weight);
title('Weight matrix')
colormap(gray);
axis square;
colorbar;





figure,plot(objfun);
title('Objective Function vs Number of Iterations');

toc;