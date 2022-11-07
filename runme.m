% Clean the previous runs
close all;
clear;
clc;

% add subdirectory path
addpath('./enhancement/')

%% Define Variables

T = 25;    % threshold
LG = 255;  % white
LB = 0;    % black

%% Read image
img = imread('./Graph_Source/airplane_grayscale.png');

%   transform the whole matrix into double, so that further processing can
%   go on
img = double(img);

%% Roberts Gradient Convolution Masks
%    mode = 1:   g(x,y) = G[f(x,y)]
img_1 = uint8(roberts(img, T, LG, LB, 1));

%    mode = 2:   g(x,y) = G[f(x,y)], if G >= T;
%                       = f(x,y), otherwise
img_2 = uint8(roberts(img, T, LG, LB, 2));

%    mode = 3:   g(x,y) = LG, if G >= T;
%                       = f(x,y), otherwise
img_3 = uint8(roberts(img, T, LG, LB, 3));

%    mode = 4:   g(x,y) = G[f(x,y)], if G >= T;
%                       = LB, otherwise
img_4 = uint8(roberts(img, T, LG, LB, 4));

%    mode = 5:   g(x,y) = LG, if G >= T;
%                              = LB, otherwise
img_5 = uint8(roberts(img, T, LG, LB, 5));

%%  Show Results
figure
imagesc(uint8(img))
title("Original Image")
colormap(gray)

figure
imagesc(img_1)
title("Method 1")
colormap(gray)

imwrite(img_1,'./Graph_Output/Method 1.bmp')

figure
imagesc(img_2)
title("Method 2")
colormap(gray)

imwrite(img_2,'./Graph_Output/Method 2.bmp')

figure
imagesc(img_3)
title("Method 3")
colormap(gray)

imwrite(img_3,'./Graph_Output/Method 3.bmp')

figure
imagesc(img_4)
title("Method 4")
colormap(gray)

imwrite(img_4,'./Graph_Output/Method 4.bmp')

figure
imagesc(img_5)
title("Method 5")
colormap(gray)

imwrite(img_5,'./Graph_Output/Method 5.bmp')
