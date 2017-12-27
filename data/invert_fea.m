function [fea1,label1]=invert_fea(fea,label,view_num)
th=view_num;
value=size(fea,2)/th;
st=zeros(1,th);
en=zeros(1,th);

for i=1:th
    st(1,i)=(i-1)*value+1;
    en(1,i)=i*value;
end

fea1=[];
label1=[];
for i=1:th
    fea1=[fea1;fea(:,st(i):en(i))];
    label1=[label1;label];
end
    
   
   
   
   
   