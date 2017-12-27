function [choose_serials_this_time,rank,diff]=our_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
method=7;
choose_num=options_active(2);
%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
% 分类    
[~,~,diff1]=QBC_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array);

pos1=find(diff1~=0);

if length(pos1)<=choose_num*5;
[~,rank2,diff2]=ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array);
[~,rank3,diff3]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array);
else
[~,rank2,diff2]=ted_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos1),options,options_active,ORorCL,view_num,al_array);
[~,rank3,diff3]=uncertainty_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind(pos1),options,options_active,ORorCL,view_num,al_array);    
end
    
score_tmp=[sort(diff2,'ascend')';sort(diff3,'ascend')'];
weight = calculate_weight(score_tmp,1,[1,1]',1); 
rank_Z=[(1:length(rank2));rank2';rank3'];
[new_rank,pos0]=agg_rank_w(method,rank_Z,choose_num,weight,[]);
if isempty(new_rank)~=1
rank=ones(1,length(rest_part_train_sample_ind))*(length(rest_part_train_sample_ind)+1);
for i=1:size(new_rank,2)
    rank(pos1(new_rank(1,i)))=new_rank(2,i);
end

else
rank=1:length(rest_part_train_sample_ind1);
end
%[~,p2]=sort(rank,'ascend');
%pos=p2(1:choose_num);
choose_serials_this_time=rest_part_train_sample_ind(pos1(pos0));
diff=weight;
end
