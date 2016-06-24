function result = train( images, masks )
features = [];
labels = [];
tic;
for i=1:30
   [fs, ls] = computeFeatures(images{i}, masks{i});
   features = cat(1, features, fs');
   labels = cat(1, labels, ls);
end

    
result = TreeBagger(32,features,labels,'OOBVarImp','on');

fprintf('Laufzeit: %f Minuten', toc / 60);

end

