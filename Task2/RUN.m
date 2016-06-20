close all

data = struct2cell(load('handdata.mat'));

shapes = data{1};
shapeModel(shapes);

clear;