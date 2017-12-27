%{
clc
clear
load('data_regression4.mat');
th=1; pca_v=20; first_every_choose_num=6;
svm_option=[1,0,1,0.125];
options_active=[1,1]; end_condition=[1,200]; train_set_per=0.8; view_num=2;
result=ALOR_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition); 

%}



function result=ALOR_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition,al_array)

mode='OR';
way= svm_option(1);
type=svm_option(2);
cfhs=svm_option(3);
hhs=svm_option(4);
cfhsandhhs=[' -c ',num2str(cfhs),' -g ',num2str(hhs),' '];
options=[' -q ',' -t ',num2str(way),' -s ',num2str(type),' ',cfhsandhhs];
accuracyte_block=[];
accuracytr_block=[];
differencete_block=[];
differencetr_block=[];
label_block=[];
%h1=waitbar(0,'开始重复实验'); 
for i=1:th
%%

%% 降维处理
[tr,te]=random_generate(new_fea,label,train_set_per);
[tr_fea,tr_label]=invert_fea(tr.fea,tr.label,view_num);
[te_fea,te_label]=invert_fea(te.fea,te.label,view_num);
[tr_fea,te_fea]=PCAdimen_new(tr_fea,te_fea,pca_v);
[tr_fea1,tr_label1]=invert_fea2(tr_fea,tr_label,view_num);
[te_fea1,te_label1]=invert_fea2(te_fea,te_label,view_num);

if options_active(1)==3
   al_array=ep_model_train(tr_fea1,view_num,'TED');
   disp('代表性AL学习结束');
elseif  options_active(1)==4
   al_array=ep_model_train(tr_fea1,view_num,'MAED');
   disp('代表性AL学习结束');
elseif  options_active(1)==9
[tmp1,~,~]=dim_one(tr_fea1,tr_label1,view_num);
sample_num=size(tmp1,1);
K=nan(sample_num,sample_num);
for ii=1:sample_num
    for jj=1:sample_num
        K(ii,jj) = tmp1(ii,:)*tmp1(jj,:)';
    end
end
al_array=K;   
end



%% 初始样本选择
[first_choose_serial,rest_choose_serial]=first_batch_acquire(tr_label1,first_every_choose_num);
now_choose_serial=first_choose_serial;
%% 开始AL  

differencetr_line=[];
differencete_line=[];
accuracytr_line=[];
accuracyte_line=[];
label_cost=[];


whether_end=0;
while (whether_end==0)
%选择样本
choose_serials_this_time =mammograph_sample_active_choose_sample(tr_fea1,tr_label1,now_choose_serial,rest_choose_serial,options,options_active,view_num,al_array,mode);
now_choose_serial=[now_choose_serial;choose_serials_this_time];
rest_choose_serial=setdiff(rest_choose_serial,choose_serials_this_time);
%测试结果
tr_label2=tr_label1(now_choose_serial,:);
tr_fea2=tr_fea1(now_choose_serial,:);

net_block=ortrain_muliteview(tr_fea2,tr_label2, view_num);
[test_resulte,accuracyte,deci_block_te]=ortest_muliteview(te_fea1,te_label1,net_block);
[test_resultr,accuracytr,deci_block_tr]=ortest_muliteview(tr_fea2,tr_label2,net_block);
diff_te=-1*mean(abs((test_resulte-te_label1)));
diff_tr=-1*mean(abs((test_resultr-tr_label2)));

%% 存储性能指标
disp(['这次Ein准确率等于',num2str(accuracytr),',Eout准确率等于',num2str(accuracyte)]);
accuracytr_line=[accuracytr_line,accuracytr];
accuracyte_line=[accuracyte_line,accuracyte];
differencetr_line=[differencetr_line,diff_tr];
differencete_line=[differencete_line,diff_te];
label_cost=[label_cost,length(tr_label2)];

whether_end=endornot_judge(tr_fea1,rest_choose_serial,options_active(2),accuracyte,end_condition);
disp(['已完成',num2str(length(now_choose_serial)),'个,共',num2str(length(tr_label1)),'个 ---第',num2str(i),'组重复实验,共',num2str(th),'组']);

end

accuracyte_block=[accuracyte_block;accuracyte_line];
accuracytr_block=[accuracytr_block;accuracytr_line];
differencete_block=[differencete_block;differencete_line];
differencetr_block=[differencetr_block;differencetr_line];
label_block=[label_block;label_cost];
%waitbar(i/th,h1,['第',num2str(i),'组重复实验,共',num2str(th),'组']);
end
result.accuracyte_block=accuracyte_block;
result.accuracytr_block=accuracytr_block;
result.differencete_block=differencete_block;
result.differencetr_block=differencetr_block;
result.label_block=label_block;
