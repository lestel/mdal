function   choose_serials_this_time  =random_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)

if strcmp(ORorCL,'CL')==1
     rest_num=length(rest_part_train_sample_ind);
     xl=randperm(rest_num);
     pos=xl(1:options_active(2));
     choose_serials_this_time=rest_part_train_sample_ind(pos);
elseif strcmp(ORorCL,'OR')==1
     rest_num=length(rest_part_train_sample_ind);
     xl=randperm(rest_num);
     pos=xl(1:options_active(2));
     choose_serials_this_time=rest_part_train_sample_ind(pos);

else
errordlg('即不是分类也不是回归无法办到');
return
end