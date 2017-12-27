function [choose_serials_this_time,rank,diff]=QBC_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
tr_fea0=tr(now_part_train_sample_ind,:);
tr_label0=tr_label(now_part_train_sample_ind,:);
te_label0=tr_label(rest_part_train_sample_ind,:);
te_fea0=tr(rest_part_train_sample_ind,:);   

%转换
view_num=2;
[tr_fea1,tr_label1,~]=dim_one(tr_fea0,tr_label0,view_num);
[te_fea1,te_label1,~]=dim_one(te_fea0,te_label0,view_num);
%% 开始判断
fea_num=size(te_fea1,2);
if strcmp(ORorCL,'CL')==1  %% 分类  
   group_num=7;  
   fea_use_num=round(fea_num*2/3);
   m=nan(size(te_fea1,1),group_num);
   for i=1:group_num
   tmp=randperm(fea_num);
   ss=tmp(1:fea_use_num);
   net=svmtrain(tr_label1,tr_fea1(:,ss),options);
   [m(:,i),~,~]=svmpredict(te_label1,te_fea1(:,ss),net);
   end
   deci=nan(size(te_fea1,1),1);
    min_v1=0.01;
   for j=1:size(te_fea1,1)
     TMP=unifrnd(0,min_v1);
     deci(j,1)=std(m(j,:))*-1+TMP;
   end
elseif  strcmp(ORorCL,'OR')==1
   group_num=10;  
   fea_use_num=round(fea_num*2/3);
   m=nan(size(te_fea1,1),group_num);
   for i=1:group_num
   tmp=randperm(fea_num);
   ss=tmp(1:fea_use_num);
   model=ordinalregression_train(tr_fea1(:,ss),tr_label1);
   [m(:,i),~,~]=ordinalregression_test2(te_fea1(:,ss),te_label1,model);
   end
   deci=nan(size(te_fea1,1),1);
   min_v1=0.01;
   for j=1:size(te_fea1,1)
     TMP=unifrnd(0,min_v1);
     deci(j,1)=std(m(j,:))*-1+TMP;
   end

end
%%

deci1=reshape(deci,[length(deci)/view_num,view_num]);
deci2=abs(deci1);
deci3=min(deci2,2);
diff=deci3;

[~,diff_pos]=sort(diff,'ascend');
rank=score_invert_rank(diff,'low');
pos=diff_pos(1:options_active(2),1);
choose_serials_this_time=rest_part_train_sample_ind(pos);