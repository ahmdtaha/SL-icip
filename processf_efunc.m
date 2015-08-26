function [ fillResult, erodedResult] = processf_efunc( f_efunc,y,height,width)


idm = applythresholdtoimage(f_efunc,0);
 
idm = reshape(idm ,height,width);
idmSmoothed = smoothImage(idm ,2,0.5);
FG = zeros(size(y));
FG(y==1)=1;
idmSmoothedFG=getconnectedcomponent(reshape(FG,height,width),idmSmoothed);

idmSmoothedFGFinal = imfill(idmSmoothedFG);

se = strel('disk',3);        
erodedBW = imerode(idmSmoothedFGFinal,se);
se = strel('disk',3);
bw2 = imdilate(erodedBW ,se);

idmSmoothedFG2=getconnectedcomponent(reshape(FG,height,width),bw2);

idmSmoothedFGFinal2 = imfill(idmSmoothedFG2);


saveResult= uint8(idmSmoothedFGFinal(:,:));
fillResult=saveResult*255;

saveResult2= uint8(idmSmoothedFGFinal2(:,:));
erodedResult=saveResult2*255;

end

