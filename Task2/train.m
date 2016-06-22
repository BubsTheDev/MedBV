function result = train( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
img = zeros(size(images,1),size(images,2));

n = nnz(masks); % number of non zero elements in mask
img(masks==10) = images(masks==10);


features = computeFeatures(img);
    
result = TreeBagger(32,features',masks,'OOBVarImp','on');

error = oobError(result);
sprintf('Error: %.f',error);

end

