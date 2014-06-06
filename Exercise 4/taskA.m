close all;
input = imread('taskA.png');
input_noise = mat2gray(imnoise(input,'gaussian',0,0.01));

fft_image_raw = fftshift(fft2(input_noise));
fft_image = log(abs(fft_image_raw)+1);
fft_image = mat2gray(fft_image);

%create gaussian filter
sigma = 1.5;
G = gauss_filter(4*sigma,sigma);

%pad filter
Filter = zeros(size(input));
for i = 1:size(G,1)
    for j = 1:size(G,2)
        Filter(i,j,1) = G(i,j);
        Filter(i,j,2) = G(i,j);
        Filter(i,j,3) = G(i,j);
    end
end


Filter = circshift(Filter, [round(-(size(G,1)/2)), round(-(size(G,2)/2))]);
fft_filter_raw = fftshift(fft2(Filter));
fft_filter = mat2gray(log(abs(fft_filter_raw)+1));
%figure('Name','Filter');
%imagesc(fft_filter)

filtered_image = fft_image_raw.*fft_filter_raw;
figure;
subplot(1,2,1),imagesc(fft_image), title('noise image');
subplot(1,2,2),imagesc(mat2gray(log(abs(filtered_image)+1))), title('filtered image');

result = ifft2(filtered_image);
figure('Name','Result Spatial Domain');
subplot(1,3,1), imshow(input), title('input image');
subplot(1,3,2),imshow(input_noise),title('noise image');
subplot(1,3,3),imshow(mat2gray(log(abs(result)+1))), title('filtered image');