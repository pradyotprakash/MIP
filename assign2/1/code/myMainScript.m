tic;
%% (A) My integration
phant = phantom('Modified Shepp-Logan',128);
% [rr cc] = meshgrid(1:80);
% phant = sqrt((rr-50).^2+(cc-40).^2)<=2;
x=linspace(-64,64,128);
y=linspace(-64,64,128);

figure,subplot(1,2,1),imagesc(x,y,phant);
title('Original Image')
colormap(gray);
axis square;
colorbar;
integral = myIntegration(phant,0,0,1)
integral = myIntegration(phant,-50,90,1)

%% (B) My Radon transform
Rf=myRadonTrans(phant,1);
x=linspace(0,175,36);
y=linspace(-90,90,37);

subplot(1,2,2),imagesc(x,y,Rf);
title('Radon Transform')
colormap(gray);
axis square;
colorbar;

%% (B) Comparing radon transforms
Rf2=myRadonTrans(phant,0.5);
Rf3=myRadonTrans(phant,3);

plot_p5_0 = Rf2(:,1)';
plot_1_0 = Rf(:,1)';
plot_3_0 = Rf3(:,1)';

plot_p5_90 = Rf2(:,19)';
plot_1_90 = Rf(:,19)';
plot_3_90 = Rf3(:,19)';

figure,subplot(3,2,1),plot(y,plot_p5_0);
title('theta=0, delta=0.5')
xlabel('Distance')
ylabel('Radon Transform Intensity')

subplot(3,2,3),plot(y,plot_1_0);
title('theta=0, delta=1')
xlabel('Distance')
ylabel('Radon Transform Intensity')

subplot(3,2,5),plot(y,plot_3_0);
title('theta=0, delta=3')
xlabel('Distance')
ylabel('Radon Transform Intensity')

subplot(3,2,2),plot(y,plot_p5_90);
title('theta=90, delta=0.5')
xlabel('Distance')
ylabel('Radon Transform Intensity')

subplot(3,2,4),plot(y,plot_1_90);
title('theta=90, delta=1')
xlabel('Distance')
ylabel('Radon Transform Intensity')

subplot(3,2,6),plot(y,plot_3_90);
title('theta=90, delta=3')
xlabel('Distance')
ylabel('Radon Transform Intensity')

figure,subplot(3,1,1),imagesc(x,y,Rf2);
title('Radon Transform delta=0.5')
colormap(gray);
axis square;
colorbar;

subplot(3,1,2),imagesc(x,y,Rf);
title('Radon Transform delta=1')
colormap(gray);
axis square;
colorbar;

subplot(3,1,3),imagesc(x,y,Rf3);
title('Radon Transform delta=3')
colormap(gray);
axis square;
colorbar;
toc;