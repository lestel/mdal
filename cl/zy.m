train_set_num=1500;
th=1;
pca_v=95;
mode='CL2';
load('HOGANDLABELFORREGURESSION.mat');

for i=1:th

%% 生成训练集与测试集

[sample_num,fea_num]=size(fea);
tmp=randperm(sample_num);
fea_new=fea(tmp,:);
label_new=label(tmp,:);
name_new=label(tmp,:);

tr=fea_new(1:train_set_num,:);
tr_label=label_new(1:train_set_num,:);
te=fea_new(train_set_num+1:end,:);
te_label=label_new(train_set_num+1:end,:);

tr1=(1:size(tr_label,1))';
te1=(1:size(te_label,1))';
[PA_rebuilt,PB_rebuilt,ycsjy_num]=PCAdimen([tr1,tr_label,tr],[te1,te_label,te],pca_v);
tr=PA_rebuilt(:,3:end);
te=PB_rebuilt(:,3:end);
% OBTAIN   tr te te_label tr_label
switch mode
    case 'CL2'
       train_sample=[(1:size(tr))',tr_label,tr];
       [net,need_type,~]=svm_building(train_sample,[2,0,1,1]);
       [test_result,evaluation,deci]=svmpredict(te_label,te,net);
 

        
        
        
    %% 初始样本选择
    label_type=unique(tr_label);
    for i=1:length(label_type)
    end
    
        
    case 'OR'








end

end
