%% detecting the processing folder 

folder = uigetdir;
currentFolder=cd;
cd(folder)
FolderContent=dir('*.tif');
cd(currentFolder)

%% Loading multi-Tiff file

for k=1:size(FolderContent,1)

    path_file=strcat(FolderContent(k).folder,'\',FolderContent(k).name);

    V=double(zeros(1536,500,500));      %volume size = 1536×500×500

    for n=1:size(V,3)
        V(:,:,n)=double(flipud(imread(path_file,n)));       %1行目が硝子体側、1536行目が強膜側の画像を扱うときは関数flipudを削除し、対応する"()"も削除する
    end

    Depth=size(V,1);
    D2z_sum=double(zeros(size(V,1),size(V,2),size(V,3)));

%% Square each pixel

    D2=V.*V;

%% Calculate Dcorr

    D2z_sum(1,:,:)  =sum(D2)-D2(1,:,:);
    for m=1:Depth-1
        D2z_sum(m+1,:,:)=D2z_sum(m,:,:)-D2(m+1,:,:);
    end
    Dcorr=D2./(2*D2z_sum+1);

%% adapting maximum value correction

    Dcorr_max=max(max(max(Dcorr(1:1200,:,:))));     %最大値を3次元空間から一点抽出した
    Dmaxval_corr=round(255*Dcorr/(Dcorr_max));
    Dmaxval_corr(Dmaxval_corr>255)=0;
    Dmaxval_corr=uint8(Dmaxval_corr);

%% resizing Y axis and reverse B/W

    Dres=uint8(255.*ones(256,500,500))-imresize3(Dmaxval_corr,[256,500,500]);

%% Saving corrected data

    l=1;
    SaveName=strcat(erase(path_file,'.tif'),'_attn-corr.tif');
    imwrite(Dres(:,:,l),SaveName)
    for l=2:size(Dres,3)
        imwrite(Dres(:,:,l),SaveName,'WriteMode','append');
    end

end