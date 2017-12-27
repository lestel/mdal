function  [choose_serials_this_time,rank,diff]=diveristy_select_sample_mu2(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
now_part_train_sample_fea=tr(now_part_train_sample_ind,:);
rest_part_train_sample_fea=tr(rest_part_train_sample_ind,:);
%% 开始判断
if strcmp(ORorCL,'CL')==1||strcmp(ORorCL,'OR')==1
option=[0,1,1/(size(tr,2))];
choose_size=options_active(2);
now_part_train_sample_num=size(now_part_train_sample_fea,1);
rest_part_train_sample_num=size(rest_part_train_sample_fea,1);

view_num=2;
each_view_fea_num=size(now_part_train_sample_fea,2)/view_num;
diveristy=ones(rest_part_train_sample_num,2)*9999999;
for i=1:rest_part_train_sample_num
    for j=1:now_part_train_sample_num
         for l=1:view_num
              st=(l-1)*each_view_fea_num+1;
              en=l*each_view_fea_num;
              distance=kernel_distance_calculate(now_part_train_sample_fea(j,st:en),rest_part_train_sample_fea(i,st:en),option);
              diveristy(i,l)=min(diveristy(i,l),distance);
         end
       
    end
end
if size(diveristy,2)>1
diff=-1*(min(diveristy')');
elseif size(diveristy,2)==1
diff=-1*diveristy;
end
    
    
    
[~,diff_pos]=sort(diff,'ascend');
rank=score_invert_rank(diff,'low');


pos=diff_pos(1:choose_size,1);
choose_serials_this_time=rest_part_train_sample_ind(pos);





else
errordlg('即不是分类也不是回归无法办到');
return
end
