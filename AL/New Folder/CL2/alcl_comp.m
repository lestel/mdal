
all_result=[];
tmp=load('1.2.mat');
s1=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s1];

tmp=load('2N.mat');
s2=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s2];

tmp=load('5.mat');
s5=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s5];
tmp=load('6.mat');
s6=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s6];
tmp=load('7.1.mat');
s7=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s7];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

tmp=load('8.1.mat');
s8=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s8];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

tmp=load('9.mat');
s9=average_score(tmp.result_block{1, 1}.accuracy_block,'CL');
all_result=[all_result;s9];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');
result_show(all_result,label_cost,[1,2,5,6,7,8],1,'CL');
title('\fontsize{10}Active Learning from two views for classification in mammography (1)')
ylabel('Accuracy');
xlabel('Pairs film-reading costs');
axis([0,300,0.6,0.96]);



figure
all_result=[];
tmp=load('1.2.mat');
s1=average_score(tmp.result_block{1, 1}.AUC_block,'11');
all_result=[all_result;s1];

tmp=load('2N.mat');
s2=average_score(tmp.result_block{1, 1}.AUC_block,'11');
all_result=[all_result;s2];

tmp=load('5.mat');
s5=average_score(tmp.result_block{1, 1}.AUC_block,'11');
all_result=[all_result;s5];
tmp=load('6.mat');
s6=average_score(tmp.result_block{1, 1}.AUC_block,'11');
all_result=[all_result;s6];
tmp=load('7.1.mat');
s7=average_score(tmp.result_block{1, 1}.AUC_block,'11');
all_result=[all_result;s7];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

tmp=load('8.1.mat');
s8=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
all_result=[all_result;s8];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

tmp=load('9.mat');
s9=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
all_result=[all_result;s9];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

result_show((all_result),label_cost,[1,2,5,6,7,8],1,'11');
title('\fontsize{10}Active Learning from two views for classification in mammography (2)')
ylabel('AUC');
xlabel('Pairs film-reading costs');
axis([0,300,0.8,1]);
