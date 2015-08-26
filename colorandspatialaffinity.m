function [ fillResult, erodedResult,f_efunc  ] = colorandspatialaffinity( OriginalImage,markerImage,ratio,max_contour)


width = size(OriginalImage,2);
height = size(OriginalImage,1);

LV = computelocationvector(height,width);
markerImage = markerImage(:);
ypos = zeros(size(markerImage));
yneg = zeros(size(markerImage));
ypos(markerImage(:,1) == 1)=1; %% original foreground
ypos(markerImage(:,1) == 3)=1; %% robot foreground
yneg(markerImage(:,1) == 2)=1; %% original background
yneg(markerImage(:,1) == 6)=1; %% robot backgroudn
y = ypos - yneg;
%figure;imagesc(reshape(y,height,width));
%positiveSample = randsample(sampleIndexes,20,true,efunc_w);

[positiveSample,negativeSample] = markers2samples(markerImage,height,width);

positiveSampleLocation = LV(positiveSample,:);
negativeSampleLocation = LV(negativeSample,:);

%figure;imagesc(OriginalImage)
%hold on;
%scatter(positiveSampleLocation(:,2),positiveSampleLocation(:,1),'red')
%scatter(negativeSampleLocation(:,2),negativeSampleLocation(:,1),'green')
%hold off;


distanceToPositive = dist2(LV,positiveSampleLocation);
distanceToPositiveVariance = var(distanceToPositive);
distanceToNegative = dist2(LV,negativeSampleLocation);
distanceToNegativeVariance = var(distanceToNegative);

[VC,VGM,VGT,VGD] = get_channels(OriginalImage,[0,1.5,3,5]);
LABcolor = getImageLabColor(OriginalImage);

%figure;imagesc(reshape(max_contour (:,1),height,width));
ICV_Positive = ic_max(max_contour,int32(height),int32(width),int32(positiveSampleLocation'));
% for i=1:20
%     figure;imagesc(reshape(ICV_Positive(:,i),height,width));
% end
%figure;imagesc(reshape(ICV_Positive (:,1),height,width));
ICV_Negative = ic_max(max_contour,int32(height),int32(width),int32(negativeSampleLocation'));



positiveSampleColor = VC(positiveSample,:);
negativeSampleColor = VC(negativeSample,:);

positiveSampleLABColor = LABcolor(positiveSample,:);
negativeSampleLABColor = LABcolor(negativeSample,:);


colorDistanceToPositive = dist2(VC,positiveSampleColor);
colorDistanceToNegative = dist2(VC,negativeSampleColor);

colorAffinityToPositive = exp(-colorDistanceToPositive);
colorAffinityToNegative = exp(-colorDistanceToNegative);

LABcolorDistanceToPositive = dist2(LABcolor,positiveSampleLABColor);
LABcolorDistanceToNegative = dist2(LABcolor,negativeSampleLABColor);

LABcolorAffinityToPositive = exp(-LABcolorDistanceToPositive);
LABcolorAffinityToNegative = exp(-LABcolorDistanceToNegative );



final_f_efunc  = zeros(width*height,1);


%% when I divide ICV with a small digit , it was dominant, while when I divide it by big number , it was no longer dominant.
ICVRatio = [1,10,50,100];
%ICVRatio = [100,50,10,1];
for i=1:1:length(ratio)


ICV_PositiveF= ICV_Positive /ICVRatio(i);
ICVPositiveAffinity = exp(-ICV_PositiveF);
%ICVPositiveAffinity = repmat(ICVPositiveAffinity ,1,20);

ICV_NegativeF= ICV_Negative /ICVRatio (i);
ICVNegativeAffinity = exp(-ICV_NegativeF);
%ICVNegativeAffinity = repmat(ICVNegativeAffinity,1,20);


distanceAffinityToPositive = bsxfun(@rdivide,-distanceToPositive,(distanceToPositiveVariance ./ ratio (i))); 
distanceAffinityToPositive = exp(distanceAffinityToPositive);


distanceAffinityToNegative = bsxfun(@rdivide,-distanceToNegative,(distanceToNegativeVariance ./ ratio (i))); 
distanceAffinityToNegative = exp(distanceAffinityToNegative);



RGBrelativeToPositive = colorAffinityToPositive .* distanceAffinityToPositive .* LABcolorAffinityToPositive .* ICVPositiveAffinity;
RGBrelativeToNegative = colorAffinityToNegative .* distanceAffinityToNegative .* LABcolorAffinityToNegative .* ICVNegativeAffinity;


TotalVector = [RGBrelativeToPositive,RGBrelativeToNegative,VC,LABcolor];
isPCAEnable = 1;
if(isPCAEnable)
    [COEFF]  = pca(TotalVector);
     TotalVector = COEFF;
end

NUM_EVECS = 100;
SIGMA_Percentage = 0.125;
lambda = 1000;
f_efunc = calculate_eigenvector(TotalVector,SIGMA_Percentage,NUM_EVECS,y,lambda); 

final_f_efunc =[final_f_efunc ,f_efunc];
end;
final_f_efunc2 = mean(final_f_efunc')';
%figure;imagesc(reshape(final_f_efunc2,height,width));
f_efunc = final_f_efunc2;

[ fillResult, erodedResult] = processf_efunc( f_efunc,markerImage,height,width);

end

