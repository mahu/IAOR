function main


%=================================================
%A. a)
input = imread('input_ex3.jpg');
grayscale = mat2gray(mean(input,3));

%=================================================
%A. b)
[Ix,Iy] = GoG(grayscale,0.5);

%=================================================
%A.c)
GradientMagnitude = sqrt(Ix.^2 + Iy.^2);

%A. d)
GradientMagnitude_binary = im2bw(GradientMagnitude,0.08);

%=================================================
%Results A. a)-d)

figure('name','Gradient of Gaussian');
subplot(1,3,1),imshow(grayscale,[]),title('grayscale image');
subplot(1,3,2),imshow(GradientMagnitude,[]),title('gradient of gaussian');
subplot(1,3,3),imshow(GradientMagnitude_binary,[]),title('thresholding');
