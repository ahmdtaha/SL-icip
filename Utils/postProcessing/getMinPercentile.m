function [ m_percentile ] = getMinPercentile( f_efunc)


xI = [];
yPercentile = [];
normalizedf_efunc = normalize(f_efunc);
for i=10:5:100
idm = getPercentile(f_efunc,i );


cost = sum(abs(normalizedf_efunc -idm ));

% lambda= 1000;
% indexes = find(Ylabel~=0);
% tmp3 = (idm - Ylabel)';
% tmp3 = tmp3(:,indexes)*lambda;
% cost  = tmp3 * (idm - Ylabel);



xI = [xI; i];
yPercentile = [yPercentile;cost];
end
[value index]= min(yPercentile);
m_percentile = xI (index);
%figure;plot(xI ,yPercentile);


end

