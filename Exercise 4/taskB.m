

close all;
clear all;

trainingImg = mat2gray(imread('trainingB.png'));

trainingImgBW = im2bw(trainingImg, graythresh(trainingImg)*0.5);

figure;
imshow(trainingImgBW);

boundaries = bwboundaries(trainingImgBW);
b = boundaries{1};

D_train = descriptorExtract(b)
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
for i= 1:size(boundaries2,1)
    b_test = boundaries2{i};
    if(size(b_test,1) > 23)
        D_test = descriptorExtract(b_test);
        distance = norm(D_test - D_train);
        if distance < thresh
            boundaries_found = [boundaries_found' ; D_test']';
        end
    end
    
       % compare D with D_train
       % accept similar Ds
       % keep related boundary 
end

boundaries_found
% plot all kept boundaries onto test img