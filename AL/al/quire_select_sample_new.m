function [choose_serials_this_time,rank,diff]=quire_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
%转换
[~,tr_label1,~]=dim_one(tr,tr_label,view_num);
sample_num=length(tr_label);
Lindex=[now_part_train_sample_ind',now_part_train_sample_ind'+sample_num];
Uindex=[rest_part_train_sample_ind,rest_part_train_sample_ind+sample_num];
label=tr_label1(Lindex,1);
lambda=1;
K=al_array;

%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1  %% 分类或回归
   deci=QUIRE_NEW(K,Lindex,Uindex,label,lambda);
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

