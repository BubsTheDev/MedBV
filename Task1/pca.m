function [ eigenval, eigenvec] = pca( D )
% Performs the PCA
%   D .... Matrix (dim x n)
%   eigenval ... eigenvalues in decreasing order
%   eigenvec ... eigenvectors of the eigenvalues

covmatrix = ourCov(D);
[eigenvec eigenval] = eig(covmatrix);

meanVec = zeros(1,size(D,1));
for i = 1:size(D,1)
    meanVec(i) = mean(D(i,:));
end
meanVec = meanVec';

%% sort
val_sorted = diag(sort(diag(eigenval),'descend'));
[B, I] = sort(diag(eigenval),'descend'); 
vec_sorted = eigenvec(:,I); 
eigenval = val_sorted;
eigenvec = vec_sorted;

result = eigenvec' * D;

%plot PCA
if size(D,1) == 2
    plot2DPCA(D', meanVec, result', eigenvec, eigenval, 1, 1);
elseif size(D,1) == 3
   % plot3DPCA(D', meanVec, eigenvec, eigenval, 1, 1)
else
    fprintf('No plotting for this matrix dimension available.'); 
end

end

