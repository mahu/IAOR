function Boundaries = DetectShape(training_image, query_image)

trainingImg = mat2gray(training_image);
trainingImgBW = im2bw(trainingImg, graythresh(trainingImg)*0.5);

training_boundaries = bwboundaries(trainingImgBW);
b = training_boundaries{1};
D_train = descriptorExtract(b);

query_image = mat2gray(query_image);
query_imageBW = im2bw(query_image, graythresh(query_image)*0.5);
query_boundaries = bwboundaries(query_imageBW);

%for every boundary -> extract D
thresh = 0.06;
Boundaries = [];

for i= 1:size(query_boundaries,1)
    b_test = query_boundaries{i};
    if(size(b_test,1) > 23)
        D_test = descriptorExtract(b_test);
        distance = norm(D_test - D_train);
        if distance < thresh
            Boundaries = [Boundaries ; query_boundaries(i)];
        end
    end
end


