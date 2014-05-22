function morphed =  morphologicalFilter(input)

structuringElement = [1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1;1,1,1,1,1];

morphOpened = imopen(input,structuringElement);
morphed = imclose(morphOpened,structuringElement);

imwrite(morphed,'morphed.jpg');


