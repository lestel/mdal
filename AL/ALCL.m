clc
clear
view_num=2;
if view_num==2
load('data_classification2.mat');
elseif view_num==1
load('data_classification2N.mat');
end
    

%%
%SETTING
t0=clock;
th=5; pca_v=100; first_every_choose_num=4;
svm_option=[1,0,1,0.125];
end_condition=[2,0.4]; train_set_per=0.5; 
all_result=[];
al_array=[];
AL_th=9;
result_block=cell(length(AL_th),1);
h1=waitbar(0,'开始不同AL实验'); 
for i=1:length(AL_th)
options_active=[AL_th(i),1];
result=ALCL_process(new_fea,label,th,train_set_per,view_num,pca_v,first_every_choose_num,svm_option,options_active,end_condition,al_array); 
result_block{i,1}=result;
all_result=[all_result;mean(result.accuracy_block,1)];
waitbar(i/length(AL_th),h1,['第',num2str(i),'组AL,共',num2str(length(AL_th)),'组']);
end

smooth_th=2;
label_cost=mean(result.label_block,1);
figure
result_show(all_result,label_cost,AL_th,smooth_th,'CL');
AAA=etime(clock,t0);
