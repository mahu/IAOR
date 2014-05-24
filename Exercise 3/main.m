function main

close all;
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
GradientMagnitude_binary = im2bw(GradientMagnitude,0.07);

%=================================================
%Results A. a)-d)

figure('name','Gradient of Gaussian');
subplot(1,3,1),imshow(grayscale,[]),title('grayscale image');
subplot(1,3,2),imshow(GradientMagnitude,[]),title('gradient of gaussian');
subplot(1,3,3),imshow(GradientMagnitude_binary,[]),title('thresholding');

%=================================================
[H,T,R] = hough_edge_detect(Ix, Iy, GradientMagnitude_binary);
size(T)
size(R)
size(H)
figure('name','Hough Voting Result');
imshow(H);

peaks = houghpeaks(H,1000)
figure('name','Hough Voting Result');
imshow(H);
hold on;
plot((peaks(:,2)),(peaks(:,1)),'+','color','red');
hold off;
T(peaks(:,2))
R(peaks(:,1))
% lines = houghlines(GradientMagnitude_binary,T,R,peaks)
% figure('name','Houghlines');
% imshow(input);
% hold on;
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end;
% hold off;
