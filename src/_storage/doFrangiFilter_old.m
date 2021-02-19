clear; close all; clc;
 
%myoctread;
load('myoctvol.mat');
% load('ExampleVolumeStent'); %ファイル読み込み
 
% Frangi Filter the stent volume　%コメント
options.BlackWhite=false; %オプション
options.FrangiScaleRange=[1 9]; %ガウスフィルターではないか
options.FrangiScaleRatio=1 ;
options.BlackWhite=false;
% options.FrangiAlpha=0.5;
% options.FrangiBeta=0.5;
% options.FrangiC=500;
%       .FrangiAlpha : Frangi vesselness constant, treshold on Lambda2/Lambda3
%					   determines if its a line(vessel) or a plane like structure
%					   default .5;
%       .FrangiBeta  : Frangi vesselness constant, which determines the deviation
%					   from a blob like structure, default .5;
%       .FrangiC     : Frangi vesselness constant which gives
%					   the threshold between eigenvalues of noise and 
%					   vessel structure. A thumb rule is dividing the 
%					   the greyvalues of the vessels by 4 till 6, default 500;
%       .BlackWhite : Detect black ridges (default) set to true, for
%                       white ridges set to false.
%       .verbose : Show debug information, default true

Vfiltered=FrangiFilter3D(V,options);
%:vはexampleVolumeStent.matの中で指定された変数　変数はsaveコマンドで指定することができる
 
% Show maximum intensity plots of input and result
figure, 
subplot(2,2,1), imshow(squeeze(max(V,[],2)),[]); title('original: max'); %
subplot(2,2,2), imshow(squeeze(max(Vfiltered,[],2)),[]); title('filtered: max');
subplot(2,2,3), imshow(V(:,:,20),[]); title('original: a some slice');
subplot(2,2,4), imshow(Vfiltered(:,:,20),[]); title('filtered: a some slice');
% figure,
% imshow3D(Vfiltered);

% change a dynamic range: [0 1]
A = Vfiltered - min(Vfiltered(:));
A = A/max(A(:));

% save the filtered volume
savedir = uigetdir(pwd, 'Select a folder to save the images');
numSlices = size(A, 3);
for iSlice = 1:numSlices
    savefilestr = sprintf('octafovea_filtered%02d.tif',iSlice);
    imwrite(A(:,:,iSlice), fullfile(savedir, savefilestr));
end