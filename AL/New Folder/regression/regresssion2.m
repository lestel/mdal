all_result=[];

load('R1.mat');
tmp=result_block;
s1=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s1];

load('R2.1.mat');
tmp=result_block;
s2=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s2];

load('R5.mat');
tmp=result_block;
s5=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s5];

load('R6.mat');
tmp=result_block;
s6=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s6];

load('R7.mat');
tmp=result_block;
s7=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s7];

load('R8.1.mat');
tmp=result_block;
s8=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s8];

load('R9.mat');
tmp=result_block;
s9=average_score(-1*tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s9];

result_show(all_result,label_cost,[1,2,5,6,7,8],1,'OR');
title('\fontsize{10}Active Learning with two views for ordinal regression in mammography (1)')
ylabel('Mean squared error');
xlabel('Pairs film-reading costs');

figure
all_result=[];

load('R1.mat');
tmp=result_block;
s1=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s1];

load('R2.1.mat');
tmp=result_block;
s2=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s2];

load('R5.mat');
tmp=result_block;
s5=average_score(tmp{1, 1}.accuracyte_block(end,:),'OR');
all_result=[all_result;s5];

load('R6.mat');
tmp=result_block;
s6=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s6];

load('R7.mat');
tmp=result_block;
s7=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s7];

load('R8.1.mat');
tmp=result_block;
s8=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s8];

load('R9.mat');
tmp=result_block;
s9=average_score(tmp{1, 1}.accuracyte_block(1,:),'OR');
all_result=[all_result;s9];

result_show(all_result,label_cost,[1,2,5,6,7,8,9],1,'OR');
title('\fontsize{10}Active Learning with two views for ordinal regression in mammography (2)')
ylabel('Accuracy');
xlabel('Pairs film-reading costs');

