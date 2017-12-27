function [choose_serials_this_time,rank,diff]=diveristy_select_sample_new2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
tr_fea0=tr(now_part_train_sample_ind,:);
tr_label0=tr_label(now_part_train_sample_ind,:);
te_label0=tr_label(rest_part_train_sample_ind,:);
te_fea0=tr(rest_part_train_sample_ind,:);   
option=[0,1,1/(size(tr,2))];

%转换
view_num=2;
[tr_fea1,~,~]=dim_one(tr_fea0,tr_label0,view_num);
[te_fea1,~,~]=dim_one(te_fea0,te_label0,view_num);
tr_num=size(tr_fea1,1);
te_num=size(te_fea1,1);
deci=nan(te_num,1);
%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1  %% 分类或回归
   for i=1:te_num
       db=nan(1,tr_num);
       for j=1:tr_num
           db(1,j)=kernel_distance_calculate(tr_fea1(j,:),te_fea1(i,:),option);
       end
       deci(i,1)=sum(db);
   end
end
%%

deci1=reshape(deci,[length(deci)/view_num,view_num]);
deci2=-1*deci1;
deci3=min(deci2,2);
diff=deci3;

[~,diff_pos]=sort(diff,'ascend');
rank=score_invert_rank(diff,'low');
pos=diff_pos(1:options_active(2),1);
choose_serials_this_time=rest_part_train_sample_ind(pos);

