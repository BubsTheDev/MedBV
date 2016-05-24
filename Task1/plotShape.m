function plotShape( shape, meanShape )
%PLOTSHAPE Summary of this function goes here
%   Detailed explanation goes here

figure;
plot(shape(1:2:end), shape(2:2:end), 'b-', meanShape(1:2:end), meanShape(2:2:end), 'r-');

end

