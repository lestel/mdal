function [choose_serials_this_time,rank,diff]=F1_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array)
choose_num=options_active(2);
%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
% 分类    
%[~,~,diff1]=QBC_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array);

%pos1=find(diff1~=0);

%if length(pos1)<=choose_num*5;
[~,rank2,diff2]=diveristy_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array);
[~,rank3,diff3]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,al_array);
%else
%[~,rank2,diff2]=diveristy_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos1),options,options_active,ORorCL,al_array);
%[~,rank3,diff3]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos1),options,options_active,ORorCL,al_array);    
%end
w2=al_array(1);
w3=al_array(2);
for i=1:length(diff2)
    diff(i,1)=(diff2(i,1)-min(diff2))*w2/(max(diff2)-min(diff2))+(diff3(i,1)-min(diff2))*w3/(max(diff2)-min(diff2));
end
   [~,diff_pos]=sort(diff,'ascend');
   rank=score_invert_rank(diff,'low');
   pos=diff_pos(1:options_active(2),1);
   choose_serials_this_time=rest_part_train_sample_ind(pos);
end
