function [choose_serials_this_time,rank,diff]=uncertainty_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
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
if strcmp(ORorCL,'CL')==1  %% 分类  
  
net=svmtrain(tr_label1,tr_fea1,options);
[~,~,deci]=svmpredict(te_label1,te_fea1,net);




elseif  strcmp(ORorCL,'OR')==1

model=ordinalregression_train(tr_fea1,tr_label1);
[~,~,abcd_te]=ordinalregression_test2(te_fea1,te_label1,model);
deci=nan(size(abcd_te,1),1);
for ii=1:size(abcd_te,1)
    tmp=sort(abcd_te(ii,:),'descend');
    deci(ii,1)=tmp(1)-tmp(2);
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

