function result = overlay(input,binaryMask)

result = zeros(size(binaryMask));
for x = 1 : size(binaryMask,1)
    for y = 1 :size(binaryMask,2)
        if ( binaryMask(x,y) == 1)
            result(x,y) = double(binaryMask(x,y))*255.0;
        end
        if(binaryMask(x,y) == 0)
            result(x,y) = double(input(x,y));
        end
    end
end
result = uint8(result);
