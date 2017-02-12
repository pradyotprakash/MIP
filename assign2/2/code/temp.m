img = phantom(256);
L_by_w = 0.5;
filterType = 'Shepp-Logan';

fftImg = fftshift(fft(img), 1);

w = 0:(size(img, 1)-1);
w = (w - w(floor(size(img,1)/2)));
w = w';
wmax = w(size(w, 1));
L = L_by_w * wmax;

wRectw = abs(w);
wRectw(wRectw > L) = 0;
	

% if strcmp(filterType, 'Ram-Lak') == 1
	mask = wRectw;
	figure, plot(mask);
% elseif strcmp(filterType, 'Shepp-Logan') == 1
	mask = ((2*L/pi) * sin((0.5*pi/L) * w) ./ w) .* wRectw ;
	mask(isnan(mask)) = 0;
	figure, plot(mask);
% elseif strcmp(filterType, 'Cosine') == 1
	mask = cos((0.5*pi/L) * w) .* wRectw;
	figure, plot(mask);
% end

filteredImg = ifftshift(bsxfun(@times, fftImg, mask), 1);
filteredImg = abs(ifft(filteredImg));