clc
clear
view_num=2;
if view_num==2
load('data_regression5.mat');
elseif view_num==1
load('data_regression5N.mat');
end


%%
%SETTING
t0=clock;
th=5; pca_v=20; first_every_choose_num=6;
svm_option=[1,0,1,0.125];
end_condition=[2,0.4]; train_set_per=0.8; view_num=2;
all_result=[];
AL_th=2;%[1,2,5,6,7];
al_array=[];
result_block=cell(length(AL_th),1);
h1=waitbar(0,'开始不同AL实验'); 
CC=[0.8,0.2;0.6,0.4;0.5,0.5;0.4,0.6;0.2,0.8];
for i=1:length(AL_th)
options_active=[AL_th(i),1];
result=ALOR_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition,CC(i,:)); 
result_block{i,1}=result;
all_result=[all_result;mean(abs(result.differencete_block),1)];
waitbar(i/length(AL_th),h1,['第',num2str(i),'组AL,共',num2str(length(AL_th)),'组']);
end

smooth_th=0;
label_cost=mean(result.label_block,1);
figure
result_show(all_result,label_cost,AL_th,smooth_th,'OR');
AAA=etime(clock,t0);
%{
all_result2=[];
for i=1:length(AL_th)
all_result2=[all_result2;mean(abs(result_block{i, 1}.accuracyte_block),1)];
end
result_show(all_result2,label_cost,AL_th,smooth_th,'OR');

AAA=etime(clock,t0);


%}
