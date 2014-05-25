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
GradientMagnitude_binary = im2bw(GradientMagnitude,0.08);

%=================================================
%Results A. a)-d)

figure('name','Gradient of Gaussian');
subplot(1,3,1),imshow(grayscale,[]),title('grayscale image');
subplot(1,3,2),imshow(GradientMagnitude,[]),title('gradient of gaussian');
subplot(1,3,3),imshow(GradientMagnitude_binary,[]),title('thresholding');

%=================================================
[H,T,R] = hough_edge_detect(Ix, Iy, GradientMagnitude_binary);


%info: threashold std is 0.5*max(H(:)) = 0.5*332
%=================================================
%f) g) h)
%Play with: Threshold
peaks = houghpeaks(H',400, 'Threshold',5);
figure('name','Hough Voting Array with local maxima');
imshow(H);
hold on;
    plot(peaks(:,1),peaks(:,2),'x','color','red', 'LineWidth',2, 'MarkerSize',10);
hold off;

%=================================================
%i) j)
%Play with: Fillgap and MinLength
lines = houghlines(GradientMagnitude_binary,T,R,peaks, 'FillGap',5,'MinLength',5);

figure('name','Houghlines');
imshow(input);
hold on;
max_len = 0;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end;
hold off;
