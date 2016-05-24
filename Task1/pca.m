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

for i = 1 : size(eigenvec,2)
eigenvec(:,i) = vec_sorted(:,i)/norm(vec_sorted(:,i));
end

end

