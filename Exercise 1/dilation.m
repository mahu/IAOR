function output = dilation(input,se)

%calculate the origin of the structuring element
origin = floor((size(se)+1)/2);

%calculate vertical offset for structuring element
verticalOffset = zeros(size(input,1),origin(2)-1);
%apply vertical offset to input image
input = [verticalOffset input verticalOffset];

%calculate horizontal offset for structuring element
horizontalOffset = zeros(origin(1)-1,size(input,2));
%apply horizontal offset to input image
input = [horizontalOffset;input;horizontalOffset];

%do the dilation
output = zeros(size(input));
for i = origin(1) : ((size(input,1)-origin(1)+1))
    for j = origin(2) : ((size(input,2)-origin(2)+1))
       %create a submatrix and check whether it contains 1's
       submatrix = input(i-origin(1)+1:i+origin(1)-1,j-origin(2)+1:j+origin(2)-1);
       if(any(submatrix(:)==1))
           %if the submatrix contains at least one 1, set the centerpixel
           %of the current submatrix to 1 in the output image
           output(i,j) = 1;
       end
    end
end

output = output(origin(1):size(output,1)-origin(1)+1,origin(2):size(output,2)-origin(2)+1);
