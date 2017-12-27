function  [choose_serials_this_time,rank,diff]=QBC_select_sample_mu(tr,tr_label,now_part_train_sample_ind,rest_part_train_sample_ind,options,options_active,ORorCL,view_num,al_array)
%% 模型导入
tr_fea1=tr(now_part_train_sample_ind,:);
tr_label1=tr_label(now_part_train_sample_ind,:);
te_label=tr_label(rest_part_train_sample_ind,:);
te_fea=tr(rest_part_train_sample_ind,:);
%% 开始判断
if strcmp(ORorCL,'CL')==1
% 分类    
net_block=svmtrain_muliteview(tr_label1,tr_fea1,options,view_num);
view_num=size(net_block,1);
each_view_fea_num=size(te_fea,2)/view_num;
sample_number_in_everyview=length(te_label);
deci_block=nan(sample_number_in_everyview,size(net_block,1));
test_result_block=nan(sample_number_in_everyview,size(net_block,1));
    for i=1:view_num
              st=(i-1)*each_view_fea_num+1;
              en=i*each_view_fea_num;
              [test_result_block(:,i),~,deci_block(:,i)]=svmpredict(te_label,te_fea(:,st:en),net_block{i,1});
    end
    diff=-1*test_if_equal(test_result_block);
    min_v=1;
    min_v1=abs(min_v/10);
    diff1=nan(length(diff),1);
    for i3=1:length(diff)
    diff1(i3,1)=unifrnd(0,min_v1)+diff(i3,1);
    end
    [~,diff_pos]=sort(diff1,'ascend');
    rank=score_invert_rank(diff,'low');
    
    pos=diff_pos(1:options_active(2),1);
    choose_serials_this_time=rest_part_train_sample_ind(pos);
elseif strcmp(ORorCL,'OR')==1
%回归
net_block=ortrain_muliteview(tr_fea1,tr_label1,view_num);
view_num=size(net_block,1);
each_view_fea_num=size(te_fea,2)/view_num;
sample_number_in_everyview=length(te_label);
deci_block=nan(sample_number_in_everyview,size(net_block,1));
test_result_block=nan(sample_number_in_everyview,size(net_block,1));
    for i=1:view_num
         st=(i-1)*each_view_fea_num+1;
         en=i*each_view_fea_num;
         [test_result_block(:,i),~,abcd_te]=ordinalregression_test2(te_fea(:,st:en),te_label,net_block{i,1});
    end
    diff=-1*test_if_equal(test_result_block);
    min_v=1;
    min_v1=abs(min_v/10);
    diff1=nan(length(diff),1);
    for i3=1:length(diff)
    diff1(i3,1)=unifrnd(0,min_v1)+diff(i3,1);
    end
    [~,diff_pos]=sort(diff1,'ascend');
    rank=score_invert_rank(diff,'low');
    
    pos=diff_pos(1:options_active(2),1);
    choose_serials_this_time=rest_part_train_sample_ind(pos);

else
errordlg('即不是分类也不是回归无法办到');
return
end

function n=test_if_equal(m)
if m==2
n=m(:,1)-m(:,2);
for i=1:length(n)
    if n(i,1)~=0
       n(i,1)=1;
    end
end
else 
    n=zeros(length(m),1);
end    
    
