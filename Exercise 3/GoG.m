function [Ix,Iy] = GoG  (input,standardDeviation)
%function GoG  (input,standardDeviation)

%=================================================
%A.a)

kernelSize = round(3 * standardDeviation);

c_x = zeros((kernelSize*2)+1);

for j = -1 * kernelSize : kernelSize
    c_x(:,j+kernelSize+1) = j;
end

c_y = c_x';

Gx = ((-1 * c_x)/(2*pi*standardDeviation^4)).*exp((-1*(c_x.^2+c_y.^2))/(2*standardDeviation^2));


Gy = Gx';

%=================================================
%A.b)

%calculate the origin of the mask elements
origin = floor((size(Gx)+1)/2);


%calculate vertical offset for structuring element
verticalOffset = zeros(size(input,1),origin(2)-1);
%apply vertical offset to input image
input = [verticalOffset input verticalOffset];

%calculate horizontal offset for structuring element
horizontalOffset = zeros(origin(1)-1,size(input,2));
%apply horizontal offset to input image
input = [horizontalOffset;input;horizontalOffset];

%do the filtering with Gx and Gy
Ix = zeros(size(input));
Iy = zeros(size(input));
for j = origin(2) : ((size(input,2)-origin(2)+1))
    for i = origin(1) : ((size(input,1)-origin(1)+1))
       %create a submatrix
       submatrix = input(i-origin(1)+1:i+origin(1)-1,j-origin(2)+1:j+origin(2)-1);
       
       multElements_x = submatrix.*Gx;
       multElements_y = submatrix.*Gy;
       Ix(i,j)= sum(multElements_x(:));
       Iy(i,j)= sum(multElements_y(:));
       

    end
end

