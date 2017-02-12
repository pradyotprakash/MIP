function [filteredImg] = myFilter(img, filterType, L_by_w)
	
	fftImg = fftshift(fft(img), 1);

	w = 0:(size(img, 1)-1);
	w = (w - w(floor(size(img,1)/2)));
	w = w';
	wmax = w(size(w, 1));
	% wmax
	L = L_by_w * wmax;
	
	wRectw = abs(w);
	wRectw(wRectw > L) = 0;
		

	if strcmp(filterType, 'Ram-Lak') == 1
		mask = wRectw;
	elseif strcmp(filterType, 'Shepp-Logan') == 1
		mask = ((2*L/pi) * sin((0.5*pi/L) * w) ./ w) .* wRectw ;
		mask(isnan(mask)) = 0;
	elseif strcmp(filterType, 'Cosine') == 1
		mask = cos((0.5*pi/L) * w) .* wRectw;
	end

	filteredImg = ifftshift(bsxfun(@times, fftImg, mask), 1);
	% filteredImg = ifftshift(fftImg, 1);
	filteredImg = real(ifft(filteredImg));
		
end