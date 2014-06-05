

close all;
clear all;

trainingImg = mat2gray(imread('trainingB.png'));

trainingImgBW = im2bw(trainingImg, graythresh(trainingImg)*0.5);

figure;
imshow(trainingImgBW);

boundaries = bwboundaries(trainingImgBW);
b = boundaries{1};

D_train = descriptorExtract(b);
%-------------------------------------------------------------------

%load test img + find boundaries
test1Img = mat2gray(imread('test1B.jpg'));
test1ImgBW = im2bw(test1Img, graythresh(test1Img)*0.5);
boundaries2 = bwboundaries(test1ImgBW);
imshow(test1ImgBW);

test2Img = mat2gray(imread('test2B.jpg'));
test2ImgBW = im2bw(test2Img, graythresh(test2Img)*0.5);
boundaries3 = bwboundaries(test2ImgBW);

%for every boundary -> extract D
thresh = 0.06;
boundaries_found = [];
positions = [];

for i= 1:size(boundaries2,1)
    b_test = boundaries2{i};
    if(size(b_test,1) > 23)
        D_test = descriptorExtract(b_test);
        distance = norm(D_test - D_train);
        if distance < thresh
            boundaries_found = [boundaries_found ; i]';
        end
    end
end
% plot all kept boundaries onto test img
boundaries_found;
points = boundaries2{4}
figure;
imshow(test1Img);
hold on;
plot(boundaries2{4}(:,2), boundaries2{4}(:,1), 'r', 'Linewidth', 3)
hold off;

boundaries_found = [];
positions = [];

for i= 1:size(boundaries3,1)
    b_test = boundaries3{i};
    if(size(b_test,1) > 23)
        D_test = descriptorExtract(b_test);
        distance = norm(D_test - D_train);
        if distance < thresh
            boundaries_found = [boundaries_found ; i]';
            disp('JA');
        end
    end
end
% plot all kept boundaries onto test img
boundaries_found;
points = boundaries3{boundaries_found(1)}
figure;
imshow(test2Img);
hold on;
plot(boundaries3{boundaries_found(1)}(:,2), boundaries3{boundaries_found(1)}(:,1), 'r', 'Linewidth', 3)
hold off;


