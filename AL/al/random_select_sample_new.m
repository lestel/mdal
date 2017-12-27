function [choose_serials_this_time,rank,diff]=random_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
tr_fea0=tr(now_part_train_sample_ind,:);
tr_label0=tr_label(now_part_train_sample_ind,:);
te_label0=tr_label(rest_part_train_sample_ind,:);
te_fea0=tr(rest_part_train_sample_ind,:);   

%转换
view_num=2;
[~,~,~]=dim_one(tr_fea0,tr_label0,view_num);
[~,te_label1,~]=dim_one(te_fea0,te_label0,view_num);
%% 开始判断
if strcmp(ORorCL,'CL')==1  %% 分类  
  
deci=(randperm(length(te_label1)))';




elseif  strcmp(ORorCL,'OR')==1
deci=(randperm(length(te_label1)))';


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

