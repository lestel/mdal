function [fea1,f_label1,f_name1,label1]=name_pp2(fea,label,f_label,f_name)
name_num=size(f_name,1);
condition=zeros(name_num,1);
condition1=zeros(name_num,1);
mark=0; 
tmp_name=cell(name_num,1);

for i=1:name_num 
     idxCC=strfind(f_name{i,1},'CC');
     if isempty(idxCC)==0
         condition1(i,1)=1;
         tmp=[1:(idxCC-1),(idxCC+2):length(f_name{i,1})];
         tmp_name{i,1}=f_name{i,1}(tmp);
     end
     idxMLO=strfind(f_name{i,1},'MLO');
     if isempty(idxMLO)==0
         condition1(i,1)=2;
         tmp=[1:(idxMLO-1),(idxMLO+3):length(f_name{i,1})];
         tmp_name{i,1}=f_name{i,1}(tmp);
     end
end


for i=1:name_num-1
   
   if condition(i,1)==0
   mark=mark+1;
   condition(i,1)=mark;
     for ii=(i+1):name_num
         if strcmp(tmp_name{i,1},tmp_name{ii,1})==1
            condition(ii,1)=mark;
         end
     end
   end
end

if condition(name_num,1)==0
   condition(name_num,1)=max(condition)+1;
end
    
CCorMLO=condition1;
CCandMLO=condition;    
num_pair=nan(1,max(CCandMLO));
for i=1:max(CCandMLO)
    num_pair(1,i)=length(find(CCandMLO==i));
end
shanjian=nan(length(CCandMLO),1);
for i=1:length(CCandMLO)
    pos=length(find(CCandMLO==CCandMLO(i)));
    shanjian(i,1)=pos;
end
zzz=find(shanjian==2);
fea1=fea(zzz,:);
f_label1=f_label(zzz,:);
f_name1=f_name(zzz,:);
label1=label(zzz,:);


