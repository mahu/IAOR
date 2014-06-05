close all;
input = imread('taskA.png');

%input = mat2gray(input);
input_noise = mat2gray(imnoise(input,'gaussian',0,0.01));

fft_image_raw = fftshift(fft2(input_noise));
fft_image = log(abs(fft_image_raw)+1);
fft_image = mat2gray(fft_image);

figure;
subplot(2,1,1), imshow(input);
subplot(2,1,2), imshow(input_noise);

figure('Name','FFT_IMAGE');
imagesc(fft_image);

sigma = 1.5;
G = gauss_filter(4*sigma,sigma);
%G = G/max(G(:));
Filter = zeros(size(input));

%Filter(1:size(G,1), 1:size(G,2)) = G(:,:);
for i = 1:size(G,1)
    for j = 1:size(G,2)
        Filter(i,j,1) = G(i,j);
        Filter(i,j,2) = G(i,j);
        Filter(i,j,3) = G(i,j);
    end
end

Filter = circshift(Filter, [round(-(size(G,1)/2)), round(-(size(G,2)/2))]);
%figure('Name','FILTER');
%imshow(Filter, []);

figure('Name','FFT_FILTER');
%fft_filter = imagesc(mat2gray(log(abs(fft2(Filter)+1))))
fft_filter_raw = fftshift(fft2(Filter));
fft_filter = mat2gray(log(abs(fft_filter_raw)+1));
imagesc(fft_filter)

mult = fft_image_raw.*fft_filter_raw;
figure('Name','Ergebnis(freq)');
imagesc(mat2gray(log(abs(mult)+1)));

result = ifft2(mult);
figure('Name','Ergebnis(intensity)');
%subplot(2,1,1),imagesc(mat2gray(log(abs(result)+1)));
subplot(2,1,1),imshow(mat2gray(log(abs(result)+1)));
subplot(2,1,2),imshow(input_noise);