%% LOADING IMAGES 

auth_img = imread('/Users/apple/Downloads/Columbia Uncompressed Image Splicing Detection/4cam_auth/canong3_02_sub_02.tif');
tamp_img = imread('/Users/apple/Documents/MATLAB/Columbia Uncompressed Image Splicing Detection/4cam_splc/canong3_canonxt_sub_16.tif');  
% Convert images to grayscale
auth_gray = im2gray(auth_img);
tamp_gray = im2gray(tamp_img);
%% *EDGE DETECTION :*

auth_edges=edge(auth_gray,'Canny');
tamp_edges=edge(tamp_gray,'Canny');
edge_diff = abs(double(tamp_edges)-double(auth_edges));
th=0.5;
tamp_regions = edge_diff>th;
h_tamp_img = tamp_img;  %highlight the tampered part
h_tamp_img(:,:,1)=uint8(tamp_regions)*255;

%checking if tampered 
a=sum(tamp_regions(:))/numel(tamp_regions);
e_th=0.1;
if a>e_th
    edge_det=true;
else
    edge_det=false;
end

%display
figure("Name",'loaded images','NumberTitle','off');
subplot(1,2,1);
imshow(auth_img);
title('Authentic image');
subplot(1,2,2);
imshow(tamp_img);
title('Tampered image');
figure("Name","edge detection analysis",'NumberTitle','off')
subplot(2,2,1);
imshow(auth_edges);
title("edges in authentic image");
subplot(2,2,2);
imshow(tamp_edges);
title("edges in tampered image");
subplot(2,2,3);
imshow(tamp_regions,[]);
title("tampered regions detected");
subplot(2,2,4);
imshow(h_tamp_img);
title("highlight tampered regions");
%% COMPRESSION ANALYSIS : 

b_size=8;
thr=20;
[map1,map2]=deal(zeros(size(auth_gray)));
for m = 1:b_size:size(auth_gray,1) - b_size + 1;
    for n = 1:b_size:size(auth_gray,2) - b_size + 1;
        b1=auth_gray(m:m+b_size-1,n:n+b_size-1);
        b2=tamp_gray(m:m+b_size-1,n:n+b_size-1);
        dct_b1=dct2(b1);
        dct_b2=dct2(b2);
        h_freq_1=sum(abs(dct_b1(4:end,4:end)),'all');
        h_freq_2=sum(abs(dct_b2(4:end,4:end)),'all');
        if h_freq_1>thr
            map1(m:m+b_size-1,n:n+b_size-1)=1;
        end
        if h_freq_2>thr
            map2(m:m+b_size-1,n:n+b_size-1)=1;
        end
    end
end
comp_diff=map2-map1;

%checking if tampered 
comp_diff_metric = sum(abs(comp_diff(:)))/numel(comp_diff);
comp_threshold=0.05;
if comp_diff_metric>comp_threshold
    comp_det=true;
else
    comp_det=false;
end

%display
figure('Name','Compression Analysis','NumberTitle','off');
subplot(1,2,1);
imshow(map1,[]);
title("compression analysis (authentic)");
subplot(1,2,2);
imshow(map2,[]);
title("compression analysis (tampered)");

figure('Name','compression map','NumberTitle','off');
imshow(comp_diff,[]);
title("difference in compression maps")

%% HISTOGRAM ANALYSIS :

auth_hist=imhist(auth_gray);
tamp_hist=imhist(tamp_gray);
regionSize=32;
[rows,cols]=size(auth_gray);
numRowRegions = ceil(rows/regionSize);
numColRegions=ceil(cols/regionSize);
correlationMap = zeros(numRowRegions,numColRegions);
for i = 1:numRowRegions
    for j=1:numColRegions
        rowStart=(i-1)*regionSize+1;
        rowEnd=min(i*regionSize,rows);
        colStart=(j-1)*regionSize+1;
        colEnd=min(j*regionSize,cols);

        auth_region=auth_gray(rowStart:rowEnd,colStart:colEnd);
        tamp_region=tamp_gray(rowStart:rowEnd,colStart:colEnd);
        authHistRegion=imhist(auth_region);
        tampHistRegion=imhist(tamp_region);

        correlationMap(i,j)=corr2(authHistRegion,tampHistRegion);
    end
end

%checking if tampered 
overall_correlation=mean(correlationMap(:));
histogram_threshold=0.85;
if overall_correlation<histogram_threshold
    hist_det=true;
else
    hist_det=false;
end

%display
figure('Name','histogram analysis','NumberTitle','off');
subplot(2,2,1);
bar(auth_hist,'FaceColor',[0 0.5 1]);
title('histogram (authentic)');
xlim([0 255]);
subplot(2,2,2);
bar(tamp_hist,'FaceColor',[0 0.5 1]);
title('histogram (tampered)');
xlim([0 255]);
subplot(2,2,[3 4]);
imagesc(correlationMap,[-1,1]);
colorbar;
title('correlation map');
xlabel('region columns');
ylabel('region rows');

%% FINAL DETECTION :

if edge_det||comp_det||hist_det
    disp('the second image is tampered');
else
    disp('the second image is not tampered');
end