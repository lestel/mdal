function  choose_serials_this_time =mammograph_sample_active_choose_sample(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,view_num,al_array,mode)

method=options_active(1);
switch method
    
case 1
     choose_serials_this_time =random_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 2      
     [choose_serials_this_time,~,~] =QBC_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array); 
case 3
     [choose_serials_this_time,~,~] =ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 4
     [choose_serials_this_time,~,~] =ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 5
     [choose_serials_this_time,~,~] =diveristy_select_sample_new2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 6
     [choose_serials_this_time,~,~]=uncertainty_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 7
     [choose_serials_this_time,~,~]=our_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 8
     [choose_serials_this_time,~,~]=MQCAL_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);
case 9
     [choose_serials_this_time,rank,diff]=quire_select_sample_new(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,mode,view_num,al_array);


end
choose_serials_this_time=reshape(choose_serials_this_time,[length(choose_serials_this_time),1]);


      

