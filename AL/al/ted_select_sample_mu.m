function  [choose_serials_this_time,rank,diff] =ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 导入标准          

%al_array 是每一个样本tr顺序下的分数
%% 开始判断
choose_size=options_active(2);
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
diff=-1*al_array(rest_part_train_sample_ind,1);
rank=score_invert_rank(diff,'low');
[~,diff_pos]=sort(diff,'ascend');
pos=diff_pos(1:choose_size,1);
choose_serials_this_time=rest_part_train_sample_ind(pos);

else
errordlg('即不是分类也不是回归无法办到');
return
end


