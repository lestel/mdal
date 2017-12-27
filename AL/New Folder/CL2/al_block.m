clc
clear
all_result=[];
all_result2=[];
tmp=load('1.2.mat');
s1=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st1=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st1];
all_result=[all_result;s1];


tmp=load('2N.mat');
s2=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st2=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st2];
all_result=[all_result;s2];


tmp=load('5.mat');
s5=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st5=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st5];
all_result=[all_result;s5];

tmp=load('6.mat');
s6=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st6=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st6];
all_result=[all_result;s6];

tmp=load('8.mat');
s8=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st8=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st8];
all_result=[all_result;s8];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

tmp=load('8.1.mat');
s9=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st9=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st9];
all_result=[all_result;s9];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');


tmp=load('7.1.mat');
s7=average_score(tmp.result_block{1, 1}.AUC_block,'CL');
st7=std(mat_cz(tmp.result_block{1, 1}.AUC_block,6));all_result2=[all_result2;st7];
all_result=[all_result;s7];
label_cost=average_score(tmp.result_block{1, 1}.label_block,'CL');

num=30;compare=7;
%CH=round(size(all_result,2)/45*[5,10,15,20,30,40]+1);
CH=1:274
mat2{1,1}=all_result(:,CH); mat2{1,2}=all_result2(:,CH);
[mat3,score_block,wlt_block,block_Z,block_R,block_B,block_X]=ttest2_block_invert(mat2,num,compare);
