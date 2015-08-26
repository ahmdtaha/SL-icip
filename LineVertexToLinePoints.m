function [ XPoints YPoints] = LineVertexToLinePoints( LabelCoordinates,delta)
%LINEVERTEXTOLINEPOINTS Summary of this function goes here
%   Detailed explanation goes here

[vertexPoints dummy] = size(LabelCoordinates);
XPoints = [];
YPoints = [];
for i=1:2:vertexPoints
    startPoint = (LabelCoordinates(i,:));
    endPoint = (LabelCoordinates(i+1,:));
    if(startPoint(1) == endPoint (1) && startPoint(2) == endPoint (2)) %% single point %% probably just noise
        XPoints = [startPoint(1)];
        YPoints = [startPoint(2)];
        return;
    end;
    xValues = [startPoint(1);endPoint(1)];
    yValues = [startPoint(2);endPoint(2)];
    if delta == 0
        delta = max(abs(endPoint(1) - startPoint(1)),abs(endPoint(2) - startPoint(2)));
        delta = round(delta * sqrt(2));
    end;
    
    displacement = (endPoint(1) - startPoint(1)) / delta;
    if(displacement == 0)
        newXValues= endPoint(1)* ones(delta ,1)';
        displacement = (endPoint(2) - startPoint(2)) / delta ;
        newYValues = startPoint(2):displacement:endPoint(2)-displacement;
    else
        newXValues= startPoint(1):displacement:endPoint(1);
        newYValues = interp1(xValues,yValues,newXValues);
    end
    
    
    newXValues = int32(newXValues);
    
    newYValues = int32(newYValues);
    
    XPoints  = [XPoints,newXValues];
    YPoints  = [YPoints,newYValues];
 
end;

end

