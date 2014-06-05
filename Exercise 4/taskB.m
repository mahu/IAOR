close all;
clear all;

trainingImg =imread('trainingB.png');
testImage = imread('test1B.jpg');

result = detectShape(trainingImg,testImage);
figure('Name','Shape Detection test1B.jpg');
imshow(testImage);
hold on;
for i = 1:size(result,1)
    array_tmp = result(1);
    plot(array_tmp{1}(:,2),array_tmp{1}(:,1), 'r', 'Linewidth', 3)
end;
hold off;


testImage = imread('test2B.jpg');

result = detectShape(trainingImg,testImage);
figure('Name','Shape Detection test2B.jpg');
imshow(testImage);
hold on;
for i = 1:size(result,1)
    array_tmp = result(1);
    plot(array_tmp{1}(:,2),array_tmp{1}(:,1), 'r', 'Linewidth', 3)
end;
hold off;


