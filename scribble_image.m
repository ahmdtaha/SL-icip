addpath(genpath('code'));
addpath(genpath('ssl'));
addpath(genpath('Utils'));

imName = 'teddy.jpg';
imAnnotation = 'teddy-anno.png';
imGt = 'teddy-gt.png';
%% RGB Image
OriginalImage = imread(imName);
width = size(OriginalImage,2);
height = size(OriginalImage,1);

%% Annotation Image
markerImage = imread(imAnnotation);
    
%% Ground Truth Image
gtImage= imread(imGt);

ratio = [512,1024,2048,4096];
percentile = 0;

LABcolor = getImageLabColor(OriginalImage);
thresh=.05:.2:0.95;
sigma=1:1:5;
RContour=canny_pb(OriginalImage(:,:,1),thresh,sigma);
GContour=canny_pb(OriginalImage(:,:,2),thresh,sigma);
BContour=canny_pb(OriginalImage(:,:,3),thresh,sigma);
LContour=canny_pb(reshape(LABcolor(:,1),height,width),thresh,sigma);
AContour=canny_pb(reshape(LABcolor(:,2),height,width),thresh,sigma);
BBContour=canny_pb(reshape(LABcolor(:,3),height,width),thresh,sigma);

max_contour = double(max([RContour(:),GContour(:),BContour(:),LContour(:),AContour(:),BBContour(:)]')');
[fillResult1, erodedResult1,f_efunc1] = colorandspatialaffinity( OriginalImage,markerImage,ratio,max_contour);
saveResult= uint8(fillResult1(:,:));
saveResult=saveResult*255;
prevLabels = markerImage;
prevSeg = saveResult;

figure;imagesc(fillResult1);

%% Computing Jaccrad Index
accuracy_measures= calculateJaccardIndex(fillResult1,gtImage);
JI11 = accuracy_measures(8)  
    