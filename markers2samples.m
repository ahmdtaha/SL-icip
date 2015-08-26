function [ positiveSample,negativeSample ] = markers2samples( markerImage,height,width )

%figure;imagesc(markerImage);
anntationLabeled=bwlabel(reshape(double(markerImage),height,width));
%figure;imagesc(anntationLabeled);
negativeSample =[];
positiveSample =[];
anntationLabeled = anntationLabeled(:);
for i=1:1:max(anntationLabeled(:))
    tmpPixelLocation =find(anntationLabeled(:)==i,1);
    if(markerImage(tmpPixelLocation) == 2) %% original Background Annotation
        [startPtX,startPtY] = ind2sub([height,width],min(find(anntationLabeled(:,1) == i)));
        [endPtX,endPtY]= ind2sub([height,width],max(find(anntationLabeled(:,1) == i)));
        [Xs,Ys] = LineVertexToLinePoints([startPtX startPtY ;endPtX endPtY],12);
        negativeSample = [negativeSample;sub2ind([height,width],Xs,Ys)'];
        
    elseif (markerImage(tmpPixelLocation) == 6)%% robot  background Annotation
        [startPtX,startPtY] = ind2sub([height,width],min(find(anntationLabeled(:,1) == i)));
        [endPtX,endPtY]= ind2sub([height,width],max(find(anntationLabeled(:,1) == i)));
        %Xs = round((startPtX+endPtX)/2);
        %Ys = startPtY;
        [Xs,Ys] = LineVertexToLinePoints([startPtX startPtY ;endPtX endPtY],2);
        negativeSample = [negativeSample;sub2ind([height,width],Xs,Ys)'];

    elseif (markerImage(tmpPixelLocation) == 1)%% original  Foreground Annotation
        [startPtX,startPtY] = ind2sub([height,width],min(find(anntationLabeled(:,1) == i)));
        [endPtX,endPtY]= ind2sub([height,width],max(find(anntationLabeled(:,1) == i)));
        [Xs,Ys] = LineVertexToLinePoints([startPtX startPtY ;endPtX endPtY],38);
        positiveSample = [positiveSample;sub2ind([height,width],Xs,Ys)'];

    elseif (markerImage(tmpPixelLocation) == 3)%% robot  Foreground Annotation
        [startPtX,startPtY] = ind2sub([height,width],min(find(anntationLabeled(:,1) == i)));
        [endPtX,endPtY]= ind2sub([height,width],max(find(anntationLabeled(:,1) == i)));
        %Xs = round((startPtX+endPtX)/2);
        %Ys = startPtY;
        [Xs,Ys] = LineVertexToLinePoints([startPtX startPtY ;endPtX endPtY],2);
        positiveSample = [positiveSample;sub2ind([height,width],Xs,Ys)'];
    end;
end
 
end

