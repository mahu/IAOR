    
function ApplyGaussMixEM
    
    % read image with 3 channels!
    [file, path, image, img_size] = read_image('Select input file for segmentation');
 
    % Number of dimensions
    n_dims = img_size(3);
    
    %--------------------------------------------------------------------------
    % number of desired components (clusters)
    % vary this parameter to find an appropriate value for the input
    % image (Task ):
    
    %n_comp = 2 :   Separates dark colors(blue,green) and edges(black) well
    %               from bright colors and background
    %n_comp = 3 :   Same as n_comp=2 + additional cluster for white color
    %n_comp = 4 :   Due to illumination changes the clustering between dark
    %               colors(blue,green,black) fails (even in same color field
    %               of upper corner);cluster(yellow,orange,red) and cluster
    %               (white)ok
    %n_comp = 5 :   Result gets worse - different clusterings on each side
    %               of cube -> incosistent due to illumination changes
    %n_comp = 6 :   Cant find clear clusters anymore (except black&white);
    %               result too inconsistent again
    %general    :   Similar colors are difficult to distinguish with higher
    %               number of clusters and easy to group with low number
    %               of clusters.
    %               Since illumination changes are higher than intensity
    %               changes of two different colors a separation of all 6
    %               different colors is impossible.
    %suitable   :   n_comp = 3 (clear and consistent clustering)
    
    n_comp = 3;
    %--------------------------------------------------------------------------
    
    % reshaping of vectors for input of EM
    trainVect = reshape(image, [img_size(1)*img_size(2),n_dims] );
    
    % sample the vectors to reduce amount of data
    desired_number = 1000;
    step = img_size(1)*img_size(2) / desired_number; 
    indices = round(1:step:img_size(1)*img_size(2));
    trainVect = trainVect(indices,:);
    
    % filter out edge points (lead to covariance-matrices which are not invertible)
    s_t = sum(trainVect,2);
    test = find(s_t ~= 3.0);
    trainVect = trainVect(test, :);
    
    % GaussMixModel mittels EM lernen...
    model = LearnGaussMixModel(trainVect, n_comp);

    % classify pixels
    ClassImg = ClassifyImage(model, image);

    % visualize result
    figure(2); 
    subplot(1,2,1), imshow(image), title('Original Image');
    subplot(1,2,2), imshow(ClassImg,[]), colormap(jet), title('Classification Result');
end



%--------------------------------------------------------------------------
% logarithmic probability of all vectors for all components
function LnVectorProb = CalcLnVectorProb(model, trainVect)

    %(TASK A.a)
    % Created by:
    % Felicitas Höbelt
    % Malik Al-Hallak
    % Sebastian Utzig

    % initialize return matrix
    LnVectorProb = [];

    weights = model.weight;

    %iterate trough all clusters
    for cluster_id = 1:size(weights,1)
        
        alpha_c = model.weight(cluster_id);
        my_c = model.mean(cluster_id,:);
        Sigma_c = squeeze(model.covar(cluster_id,:,:));
        
        prob_c =[];
        for feature_id = 1:size(trainVect,1)
            
            feature_vec = trainVect(feature_id,:);            
            diff = feature_vec'-my_c';
               
            logProb = log(alpha_c)-0.5*(log(det(Sigma_c))+diff'*inv(Sigma_c)*diff);
            
            prob_c = [prob_c,logProb];
            
        end        
        LnVectorProb = [LnVectorProb;prob_c];        
    end
end


%--------------------------------------------------------------------------
function  ClassImg = ClassifyImage(model, image)
    
    % image dimensions
    s = size(image);
   
    % reshaping of feature vectors
    FeatureVects = reshape(image, [s(1)*s(2),s(3)]);
    
    % probability of all vectors for all clusters (classes)
    LnVectorProb = CalcLnVectorProb(model, FeatureVects);  
    
    % get the maximum value --> this is the corresponding class membership
    [max_values, max_pos]  = max(LnVectorProb,[],1); 
    
    % reshape vector to result array
    ClassImg = uint8(reshape(max_pos, s(1:2)));
end

%--------------------------------------------------------------------------
function [file, path, image, s] = read_image(text)

    % open a dialogue to pick afile
    [file, path] = uigetfile('*.*', text);
 
    % read image and convert to double [0,...,1]
    image = mat2gray( imread([path,file]) );
    
    % determine size/dimensions of image
    s = size(image);
end