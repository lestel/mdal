clc
clear
all_result=[];
all_result2=[];

load('R1.mat');
tmp=result_block;
s1=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s1];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];

load('R2.mat');
tmp=result_block;
s2=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s2];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];

load('R5.mat');
tmp=result_block;
s5=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s5];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];

load('R6.mat');
tmp=result_block;
s6=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s6];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];

load('R8.1.mat');
tmp=result_block;
s8=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s8];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];

load('R9.mat');
tmp=result_block;
s9=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s9];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];


load('R7.mat');
tmp=result_block;
s7=average_score(tmp{1, 1}.differencete_block(1,:),'OR');
all_result=[all_result;s7];
st1=std(mat_cz(tmp{1, 1}.differencete_block,3));all_result2=[all_result2;st1];



result_show(all_result,label_cost,[1,2,5,6,8,9,7],1,'OR');

num=30;compare=7;
%CH=round(size(all_result,2)/45*[5,10,15,20,30,40]+1);
CH=1:396
mat2{1,1}=all_result(:,CH); mat2{1,2}=all_result2(:,CH);
[mat3,score_block,wlt_block,block_Z,block_R,block_B,block_X]=ttest2_block_invert(mat2,num,compare);