%Inclass 13
%GB comments
1a 70 To use this method, it is best to use a larger radial value in the morphological structuring element. Change 15 to 150 and the resulting image is much more reasonable. 
1b 100 Threshold number is pretty low. I get a lot of fused nuclei 
1c 100
1d 100
2a 100
2b 100
2c 100
overall: 96


%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright. 

img1 = imread('Dish1Well8Hyb1Before_w0001_m0006.tif');
imshow(img1, []);
img1_double = im2double(img1);
img1_double = img1_double .* (img1_double>0.07);
img1_double_dilate = imdilate(img1_double, strel('disk', 30));
img1_norm = img1_double./img1_double_dilate;
imshow(img1_norm,[]);

% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true. 

img1_norm_nuc = img1_norm > 0.25;
imshow(img1_norm_nuc, []);

% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.

edge_img1 = imdilate(edge(img1_double, 'canny', [0.05 0.12]), strel('disk', 1));
imshow(edge_img1, []);

% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 

color_image = cat(3, im2double(imadjust(img1)), img1_norm_nuc, edge_img1);
imshow(color_image,[]);

%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the object

centers = regionprops(img1_norm_nuc, 'Centroid');

%B. display the mask and plot the centers of the objects on top of the
%objects

centroids = cat(1, centers.Centroid);
imshow(img1_norm_nuc, []);
hold on;
plot(centroids(:,1), centroids(:,2), 'rx');

%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 

plot(centroids(:,1), 1024-centroids(:,2) , 'rx');
xlim([0 1024]);
ylim([0 1024]);
