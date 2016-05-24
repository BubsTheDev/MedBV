function [ eigenval, eigenvec] = pca( D )
% Performs the PCA
%   D .... Matrix (dim x n)
%   eigenval ... eigenvalues in decreasing order
%   eigenvec ... eigenvectors of the eigenvalues

covmatrix = ourCov(D);
[eigenvec, eigenval] = eig(covmatrix);

[val_sorted, I] = sort(diag(eigenval),'descend'); 
vec_sorted = eigenvec(:,I);
eigenval = val_sorted;
eigenvec(:,1) = vec_sorted(:,1)/norm(vec_sorted(:,1));
eigenvec(:,2) = vec_sorted(:,2)/norm(vec_sorted(:,2));

end

