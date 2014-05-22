function main 

input = imread('input_sat_image.jpg');

enhancedGrayscale = enhanceContrast(input);
binaryMask = toBinaryMask(enhancedGrayscale,80);

morphed = morphologicalFilter(binaryMask);
result = overlay(enhancedGrayscale,morphed);

figure('name','Workflow');
subplot(2,3,1), imshow(input),title('Input Image');
subplot(2,3,2), imshow(enhancedGrayscale),title('Enhanced Contrast Image');
subplot(2,3,3), imshow(binaryMask),title('Binary Image');
subplot(2,3,4), imshow(morphed),title('Morphed Image');
subplot(2,3,5), imshow(result),title('Result Image');

imwrite(result,'result.jpg');


structuringElement = [1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1];
matlabDilation = imdilate(binaryMask,structuringElement);
ownDilation = dilation(binaryMask, structuringElement);
difference = abs(matlabDilation - ownDilation);
%C)
%   d) There are no differences besides the elapsed time. The self-made
%   function needs more time. But since we are working on single pixels we
%   could parallelize and speed up the computation.

figure('name','Dilation Comparison');
subplot(2,2,1),imshow(matlabDilation),title('Matlab Dilation');
subplot(2,2,2),imshow(ownDilation),title('Own Dilation');
subplot(2,2,3),imshow(binaryMask),title('Binary Mask');
subplot(2,2,4),imshow(difference),title('Difference Image');


%E)
%The results are pretty ok. There are some spots on the image which are not
%water but are recognized as region of interest. In the example image
%these spots are shadows. On the other hand there are some waves on the 
%river which are marked as land because they are white. So the limitations 
%of this approach is the thresholding. For more complex images with many
%objects having the same gray value they cannot be distinguished by this
%approach. Furhtermore same objects having different gray values (e.g. due to
%light) would be erroneous distinguished.