clear;

daten = struct2cell(load('daten.mat'));
daten3d = struct2cell(load('daten3d.mat'));
shapes = struct2cell(load('shapes.mat'));

for i=1:4
   %% 1b)
   covm = ourCov(daten{i});
   fprintf('Kovarianzmatrix data%d:\n',i);
   disp(covm);
   %% 2a)
   [eigenval eigenvec] = pca(daten{i});
 
   %% 3a) TODO: Projizieren
   if(i == 3)
       eigenval_d3 = eigenval;
       eigenvec_d3 = eigenvec;
   end
   
end

%% 4a)
pca3d = pca(daten3d{1});