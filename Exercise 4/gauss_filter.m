function G = gauss_filter  (kernelsize,sigma)

[x y ]= meshgrid(-floor(kernelsize/2):floor(kernelsize/2),-floor(kernelsize/2):floor(kernelsize/2));

G = exp(-(x.^2+y.^2)/(2*sigma^2));
G= G./sum(G(:));
