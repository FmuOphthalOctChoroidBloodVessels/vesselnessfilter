clear; close all; clc;

%%  You nedd to compile a mex file (only when you never have done)
%   mex eig3volume.c

%% Read Volume data from DICOM
% select a dicom file
[dcmfile, dcmpath] = uigetfile('DCM', 'Select a DICOM file', '*.DCM');

% Read the dicom file: DICOMREAD
[V, map] = dicomread(fullfile(dcmpath, dcmfile));
V = squeeze(V); % height x width x depth(=1) x slices -> height x width x slices

%% Set options for the Frange Filter
options.BlackWhite=false; %オプション
options.FrangiScaleRange=[3 3]; %ガウスフィルターではないか
options.FrangiScaleRatio=1;

%% Apply the filter to the vlume
Vfiltered=FrangiFilter3D(V, options);

%% Show maximum intensity plots of input and result
figure, 
subplot(2,2,1), imshow(squeeze(max(V,[],2)),[]); title('original: max'); %
subplot(2,2,2), imshow(squeeze(max(Vfiltered,[],2)),[]); title('filtered: max');
subplot(2,2,3), imshow(V(:,:,20),[]); title('original: a some slice');
subplot(2,2,4), imshow(Vfiltered(:,:,20),[]); title('filtered: a some slice');
figure,
imshow3D(Vfiltered);

%% change a dynamic range: [0 1]
A = double(Vfiltered - min(Vfiltered(:)));
A = A/max(A(:));
 
%% save the filtered volume
savedir = uigetdir(pwd, 'Select a folder to save the images');
numSlices = size(A, 3);
for iSlice = 1:numSlices
    savefilestr = sprintf('octafovea_filtered%02d.tif',iSlice);
    imwrite(A(:,:,iSlice), fullfile(savedir, savefilestr));
end