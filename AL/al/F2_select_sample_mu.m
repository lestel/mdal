function [choose_serials_this_time,rank,diff]=F2_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array)
%choose_num=options_active(2);
%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
% 分类    


if al_array>0
[~,~,diff2]=diveristy_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array);
[~,diff_pos]=sort(diff2,'ascend');
pos=diff_pos(1:al_array,1);
[~,~,diff3]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos),options,options_active,ORorCL,al_array);
else
[~,~,diff2]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array);
[~,diff_pos]=sort(diff2,'ascend');
pos=diff_pos(1:abs(al_array),1);
[~,~,diff3]=diveristy_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos),options,options_active,ORorCL,al_array);
end
[~,diff_pos]=sort(diff3,'ascend');
pos1=diff_pos(1:options_active(2),1);
choose_serials_this_time=rest_part_train_sample_ind(pos(pos1));
rank=[];
diff=[];

end
