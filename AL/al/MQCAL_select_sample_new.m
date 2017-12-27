function [choose_serials_this_time,rank,diff]=MQCAL_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
first_BATCH=7;
[choose_serials_this_time1,~,~]=uncertainty_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,[6,first_BATCH],ORorCL,view_num,al_array);

[choose_serials_this_time,~,~]=uncertainty_select_sample_new(tr,tr_label,now_part_train_sample_ind,choose_serials_this_time1,options,options_active,ORorCL,view_num,al_array);

rank=[];
diff=[];