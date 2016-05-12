function [ C ] = ourCov( D )
%ORCOV Summary of this function goes here
%   D .... Matrix (2x50)
%   C .... calculated covariance matrix
    n = length(D);
    meanVec = [mean(D(1,:)) mean(D(2,:))]';
    C = zeros(2);
    for i = 1:n 
        C = C + (D(:,i) - meanVec) * (D(:,i) - meanVec)';     
    end
    
    C = C/(n-1);
end

