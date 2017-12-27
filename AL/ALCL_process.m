
%{

clc
clear
load('data_classification2.mat');
th=1; pca_v=100; first_every_choose_num=4;
svm_option=[1,0,1,0.125];
options_active=[2,1]; end_condition=[1,100]; train_set_per=0.5; view_num=2;
result=ALCL_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition); 

%}



function result=ALCL_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition,al_array)

mode='CL';
way= svm_option(1);
type=svm_option(2);
cfhs=svm_option(3);
hhs=svm_option(4);
cfhsandhhs=[' -c ',num2str(cfhs),' -g ',num2str(hhs),' '];
options=[' -q ',' -t ',num2str(way),' -s ',num2str(type),' ',cfhsandhhs];
accuracy_block=[];
precision_block=[];
recall_block=[];
fp_block=[];
F1measure_block=[];
AUC_block=[];
label_block=[];
%h1=waitbar(0,'��ʼ�ظ�ʵ��'); 
for i=1:th
%%

%% ��ά����
[tr,te]=random_generate(new_fea,label,train_set_per);
[tr_fea,tr_label]=invert_fea(tr.fea,tr.label,view_num);
[te_fea,te_label]=invert_fea(te.fea,te.label,view_num);
[tr_fea,te_fea]=PCAdimen_new(tr_fea,te_fea,pca_v);
[tr_fea1,tr_label1]=invert_fea2(tr_fea,tr_label,view_num);
[te_fea1,te_label1]=invert_fea2(te_fea,te_label,view_num);

if options_active(1)==3
   al_array=ep_model_train_new(tr_fea1,view_num,'TED');
   disp('������ALѧϰ����');
elseif  options_active(1)==4
   al_array=ep_model_train_new(tr_fea1,view_num,'MAED');
   disp('������ALѧϰ����');
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



%% ��ʼ����ѡ��
[first_choose_serial,rest_choose_serial]=first_batch_acquire(tr_label1,first_every_choose_num);
now_choose_serial=first_choose_serial;
%% ��ʼAL  



accuracy_line=[];
precision_line=[];
recall_line=[];
fp_line=[];
F1measure_line=[];
AUC_line=[];
label_cost=[];


whether_end=0;
while (whether_end==0)
%ѡ������
choose_serials_this_time =mammograph_sample_active_choose_sample(tr_fea1,tr_label1,now_choose_serial,rest_choose_serial,options,options_active,view_num,al_array,mode);
now_choose_serial=[now_choose_serial;choose_serials_this_time];
rest_choose_serial=setdiff(rest_choose_serial,choose_serials_this_time);
%���Խ��
tr_label2=tr_label1(now_choose_serial,:);
tr_fea2=tr_fea1(now_choose_serial,:);


net_block=svmtrain_muliteview(tr_label2,tr_fea2,options,view_num);
[test_resultF,~,deci_blockF]=svmpredict_muliteview(te_fea1,te_label1,net_block);

%% �洢����ָ��
deci_blockF2=mean(deci_blockF,2);
[~,accuracy,precision,recall,fp,F1measure]=confusion_table_make(test_resultF,te_label1,1);
AUC = AUC_calculate(deci_blockF2,te_label1,net_block{1,1});
disp(['���׼ȷ�ʵ���',num2str(accuracy)]);
accuracy_line=[accuracy_line,accuracy];
precision_line=[precision_line,precision];
recall_line=[recall_line,recall];
fp_line=[fp_line,fp];
F1measure_line=[F1measure_line,F1measure];
AUC_line=[AUC_line,AUC];
label_cost=[label_cost,length(tr_label2)];
whether_end=endornot_judge(tr_fea1,rest_choose_serial,options_active(2),accuracy,end_condition);
disp(['�����',num2str(length(now_choose_serial)),'��,��',num2str(length(tr_label1)),'�� ---��',num2str(i),'���ظ�ʵ��,��',num2str(th),'��']);

end

accuracy_block=[accuracy_block;accuracy_line];
precision_block=[precision_block;precision_line];
recall_block=[recall_block;recall_line];
fp_block=[fp_block;fp_line];
F1measure_block=[F1measure_block;F1measure_line];
AUC_block=[AUC_block;AUC_line];
label_block=[label_block;label_cost];
%waitbar(i/th,h1,['��',num2str(i),'���ظ�ʵ��,��',num2str(th),'��']);
end
result.accuracy_block=accuracy_block;
result.precision_block=precision_block;
result.recall_block=recall_block;
result.fp_block=fp_block;
result.F1measure_block=F1measure_block;
result.AUC_block=AUC_block;
result.label_block=label_block;
