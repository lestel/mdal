function [fea1,label1,x1]=dim_one(fea,label,view_num)
%two view×ª»»
each_view_fea_num=size(fea,2)/view_num;
fea1=[];
label1=[];
x=(1:size(fea,1))';
x1=[];
for i=1:view_num
    st=(i-1)*each_view_fea_num+1;
    en=i*each_view_fea_num;
    fea1=[fea1;fea(:,st:en)];
    label1=[label1;label];
    x1=[x1;x];
end
