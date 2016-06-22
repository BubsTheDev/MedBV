function result = train( images, masks )
%TRAIN Summary of this function goes here
%   Detailed explanation goes here
 
features = computeFeatures(images);
    
result = TreeBagger(32,features',masks,'OOBVarImp','on');

end

