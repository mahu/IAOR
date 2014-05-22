function enhancedImage = enhanceContrast (input)
    %transfer rgb image to grayscale image
    grayscale = rgb2gray(input);
   
    %calculate maximum gray-value
    maxGray = max(grayscale(:));
    minGray = min(grayscale(:));
    
    enhancedImage = uint8(double(grayscale-minGray)/double(maxGray-minGray).*255.0);
    imwrite(enhancedImage,'enhanced.jpg');
    figure('name','Enhanced Contrast');
    subplot(2,2,1),imshow(input),title('Input Image');
    subplot(2,2,2),imshow(enhancedImage),title('Enhanced Image');
    subplot(2,2,3),imhist(grayscale),title('Input Histogram');
    subplot(2,2,4),imhist(enhancedImage),title('Enhanced Histogram');
    
    %c) The histogram of the input image shows that the gray values of the
    %image varies between 150 and 220. So the image only uses a range of 70
    %instead of 256.
    
    %e) After the contrast stretching the image uses the full range
    %between 0 and 255. Since the stretching only happens in horicontal
    %direction the shape of the initial curve of the histogram is
    %preserved.
    