function  [choose_serials_this_time,rank,diff] =ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% �����׼          

%al_array ��ÿһ������tr˳���µķ���
%% ��ʼ�ж�
choose_size=options_active(2);
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
diff=-1*al_array(rest_part_train_sample_ind,1);
rank=score_invert_rank(diff,'low');
[~,diff_pos]=sort(diff,'ascend');
pos=diff_pos(1:choose_size,1);
choose_serials_this_time=rest_part_train_sample_ind(pos);

else
errordlg('�����Ƿ���Ҳ���ǻع��޷��쵽');
return
end


