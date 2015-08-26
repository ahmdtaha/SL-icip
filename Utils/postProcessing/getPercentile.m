function [ idm ] = getPercentile( f_efunc,step)

statVariable = f_efunc;
idm = ones(size(f_efunc))*1;
p0 = prctile(statVariable,0);
p100 = prctile(statVariable,100);


pStep = prctile(statVariable,step);
idm(pStep>=f_efunc(:,1) & f_efunc(:,1) >=p0)=0;
idm(p100>=f_efunc(:,1) & f_efunc(:,1) >=pStep)=1;

% idm(p20>=f_efunc(:,1) & f_efunc(:,1) >=p0)=-1;
% idm(p40>=f_efunc(:,1) & f_efunc(:,1) >=p20)=-1;
% idm(p60>=f_efunc(:,1) & f_efunc(:,1) >=p40)=-1;
% idm(p80>=f_efunc(:,1) & f_efunc(:,1) >=p60)=-1;
% idm(p90>=f_efunc(:,1) & f_efunc(:,1) >=p80)=1;
% idm(p100>=f_efunc(:,1) & f_efunc(:,1) >=p90)=1;%f_efunc(p100>=f_efunc(:,1) & f_efunc(:,1) >=p90);
% 


end

