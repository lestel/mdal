function net_block=svmtrain_muliteview(tr_label,tr_fea,options,view_num)
each_view_fea_num=size(tr_fea,2)/view_num;
net_block=cell(view_num,1); 

for i=1:view_num
    st=(i-1)*each_view_fea_num+1;
    en=i*each_view_fea_num;
    net_block{i,1}=svmtrain(tr_label,tr_fea(:,st:en),options);
end


