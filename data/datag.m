load('HOGANDLABELFORREGURESSION.mat');
[fea,f_label,f_name,r_label]=name_pp2(f_hog,label,f_label,f_name);
[CCandMLO,tmp_name,CCorMLO]=name_pp(f_name);
new_fea_num=size(fea,2)*2;
new_sample_num=max(CCandMLO);
new_fea=nan(new_sample_num,new_fea_num);
new_f_label=nan(new_sample_num,2);
new_f_name=cell(new_sample_num,2);
new_r_label=nan(new_sample_num,2);
for i=1:new_sample_num
    pos0=find(CCandMLO==i);
    pos1=find(CCorMLO==1);
    pos2=find(CCorMLO==2);
    pos=[intersect(pos0,pos1), intersect(pos0,pos2)];
    new_fea(i,:)=[fea(pos(1),:),fea(pos(2),:)];
    new_f_label(i,:)=[f_label(pos(1),1),f_label(pos(2),1)];
    new_f_name{i,1}=tmp_name{pos(1),1};
    new_f_name{i,2}=tmp_name{pos(2),1};
    new_r_label(i,:)=[r_label(pos(1),1),r_label(pos(2),1)];
end
name=new_f_name(:,1);

%% for classification
label=nan(size(new_f_label,1),1);
for i=1:size(new_f_label,1)
   if new_f_label(i,1)==-1
   label(i,1)=1;
   elseif new_f_label(i,1)==0
   label(i,1)=1;
   elseif new_f_label(i,1)==1
   label(i,1)=-1;
   end
end
save('data_classification2.mat','label','new_fea','name');

label=nan(size(new_f_label,1),1);
for i=1:size(new_f_label,1)
if new_f_label(i,1)==-1
   label(i,1)=1;
elseif new_f_label(i,1)==0
   label(i,1)=0;
elseif new_f_label(i,1)==1
   label(i,1)=-1;
end
end
save('data_classification3.mat','label','new_fea','name');


new_fea1=new_fea;
name1=name;
new_r_label1=new_r_label(:,1);
%% for 4regression

pos=[find(new_r_label1==2);find(new_r_label1==3);find(new_r_label1==4);find(new_r_label1==5)];

new_fea=new_fea1(pos,:);
name=name1(pos,1);
label=new_r_label(pos,1);
save('data_regression4.mat','label','new_fea','name');

%% for 5regression

pos=[find(new_r_label1==1);find(new_r_label1==2);find(new_r_label1==3);find(new_r_label1==4);find(new_r_label1==5)];

new_fea=new_fea1(pos,:);
name=name1(pos,1);
label=new_r_label(pos,1);
save('data_regression5.mat','label','new_fea','name');

%}





