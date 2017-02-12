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
iradTrans = iradon(radTrans,angles, 'linear', 'none');
subplot(1,3,3),imagesc(x,y,iradTrans);
title('Backprojection')
colormap(gray);
axis square;
colorbar;

%using filters for inverse radon 
iradTrans1 = iradon(myFilter(radTrans, 'Ram-Lak', 0.5), angles, 'linear', 'none');
iradTrans4 = iradon(myFilter(radTrans, 'Ram-Lak', 1), angles, 'linear', 'none');
iradTrans2 = iradon(myFilter(radTrans, 'Shepp-Logan', 0.5), angles, 'linear', 'none');
iradTrans5 = iradon(myFilter(radTrans, 'Shepp-Logan', 1), angles, 'linear', 'none');
iradTrans3 = iradon(myFilter(radTrans, 'Cosine', 0.5), angles, 'linear', 'none');
iradTrans6 = iradon(myFilter(radTrans, 'Cosine', 1), angles, 'linear', 'none');

figure, subplot(2, 3, 1), imagesc(x,y,iradTrans1);
title('Ram-Lak, L = w_{max}/2');
colormap(gray);
axis square;
colorbar;

subplot(2, 3, 2), imagesc(x,y,iradTrans2);
title('Shepp-Logan, L = w_{max}/2');
colormap(gray);
axis square;
colorbar;

subplot(2, 3, 3), imagesc(x,y,iradTrans3);
title('Cosine, L = w_{max}/2');
colormap(gray);
axis square;
colorbar;

subplot(2, 3, 4), imagesc(x,y,iradTrans4);
title('Ram-Lak, L = w_{max}');
colormap(gray);
axis square;
colorbar;

subplot(2, 3, 5), imagesc(x,y,iradTrans5);
title('Shepp-Logan, L = w_{max}');
colormap(gray);
axis square;
colorbar;

subplot(2, 3, 6), imagesc(x,y,iradTrans6);
title('Cosine, L = w_{max}');
colormap(gray);
axis square;
colorbar;




%% (A) Radon transform on blurred images
phant = phantom(256);
S0 = mapTo01(phant);
S1 = mapTo01(conv2(phant, fspecial('gaussian', 11, 1),'same'));
S5 = mapTo01(conv2(phant, fspecial('gaussian', 51, 5),'same'));

% x=linspace(-128,128,256);
% y=linspace(-128,128,256);
% figure,subplot(1,3,1),imagesc(x,y,S0);
% title('S0')
% colormap(gray);
% axis square;
% colorbar;
% subplot(1,3,2),imagesc(x,y,S1);
% title('S1')
% colormap(gray);
% axis square;
% colorbar;
% subplot(1,3,3),imagesc(x,y,S5);
% title('S5')
% colormap(gray);
% axis square;
% colorbar;


R0 = iradon(myFilter(radon(S0, angles), 'Ram-Lak', 1), angles, 'linear', 'none', size(S0, 1));
R0 = mapTo01(R0);
% R0 = R0(2:(size(R0,1)-1), 2:(size(R0,2)-1));
R1 = iradon(myFilter(radon(S1, angles), 'Ram-Lak', 1), angles, 'linear', 'none', size(S1, 1));
R1 = mapTo01(R1);
% R1 = R1(2:(size(R1,1)-1), 2:(size(R1,2)-1));
R5 = iradon(myFilter(radon(S5, angles), 'Ram-Lak', 1), angles, 'linear', 'none', size(S5, 1));
R5 = mapTo01(R5);


% figure,subplot(1,3,1),imagesc(x,y,R0);
% title('R0')
% colormap(gray);
% axis square;
% colorbar;
% subplot(1,3,2),imagesc(x,y,R1);
% title('R1')
% colormap(gray);
% axis square;
% colorbar;
% subplot(1,3,3),imagesc(x,y,R5);
% title('R5')
% colormap(gray);
% axis square;
% colorbar;
% R5 = R5(2:(size(R5,1)-1), 2:(size(R5,2)-1));


fprintf('RRMSE 0 : %f \n', myRRMSE(S0, R0));
fprintf('RRMSE 1 : %f \n', myRRMSE(S1, R1));
fprintf('RRMSE 5 : %f \n', myRRMSE(S5, R5));

wmax = floor(size(radTrans, 1)/2);

% tempimg = iradon(myFilter(radon(S0, angles), 'Ram-Lak', double(1/wmax)), angles, 'linear', 'none', size(S0, 1));
% tempimg = mapTo01(tempimg);
% figure,imagesc(x,y,tempimg);
% title('tempimg')
% colormap(gray);
% axis square;
% colorbar;

% tempRRMSE = myRRMSE(S0, tempimg)

% tempimg1 = iradon(myFilter(radon(S0, angles), 'Ram-Lak', double(1)), angles, 'linear', 'none', size(S0, 1));
% tempimg1 = mapTo01(tempimg1);
% figure,imagesc(x,y,tempimg1);
% title('tempimg1')
% colormap(gray);
% axis square;
% colorbar;

% tempRRMSE = myRRMSE(S0, tempimg1)



plotarray0 = [];
plotarray1 = [];
plotarray5 = [];

varh = 0;
h = waitbar(varh, 'Computing plot versus L');

for L = 1:wmax
	tempval0 = myRRMSE(S0, mapTo01(iradon(myFilter(radon(S0, angles), 'Ram-Lak', double(L/wmax)), angles, 'linear', 'none', size(S0, 1))));
	tempval1 = myRRMSE(S1, mapTo01(iradon(myFilter(radon(S1, angles), 'Ram-Lak', double(L/wmax)), angles, 'linear', 'none', size(S1, 1))));
	tempval5 = myRRMSE(S5, mapTo01(iradon(myFilter(radon(S5, angles), 'Ram-Lak', double(L/wmax)), angles, 'linear', 'none', size(S5, 1))));
	plotarray0 = [plotarray0, tempval0];
	plotarray1 = [plotarray1, tempval1];
	plotarray5 = [plotarray5, tempval5];
	waitbar(double(L/wmax));
end

close(h);

figure, plot(plotarray0), title('RRMSE(S_0, R_0) vs L');
figure, plot(plotarray1), title('RRMSE(S_1, R_1) vs L');
figure, plot(plotarray5), title('RRMSE(S_5, R_5) vs L');



toc;

