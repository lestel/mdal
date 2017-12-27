
%http://www.cad.zju.edu.cn/home/dengcai/Data/ActiveLearning.html
%Two circles data with noise
clear;	
[fea,gnd]=generate_basic_pic(9);
mat=pretreatment_matrix(fea,gnd,1,0);

split = gnd ==1;
%split = zeros(400,1);
%split(1:20,1)=1;
%split=logical(split);
xs_NUM=20;
each_itertion=2;

smpRank=nan(xs_NUM,3);
figure(1);
plot(fea(split,1),fea(split,2),'.k',fea(~split,1),fea(~split,2),'.b');

%Actively select 8 examples using TED
options = [];
options.KernelType = 'Gaussian';
options.t = 0.5;
options.ReguBeta = 0;
%MAED boils down to TED when ReguBeta = 0;
[smpRank(:,1),VAL] = MAED(fea,xs_NUM,options);
subplot(221);
plot(fea(split,1),fea(split,2),'.k',fea(~split,1),fea(~split,2),'.b');
hold on;
for i = 1:size(smpRank,1)
  plot(fea(smpRank(i,1),1),fea(smpRank(i,1),2),'*r');
  text(fea(smpRank(i,1),1),fea(smpRank(i,1),2),['\fontsize{16} \color{red}',num2str(i)]);
end
hold off;

%Actively select 8 examples using MAED
options = [];
options.KernelType = 'Gaussian';
options.t = 0.5;
options.ReguBeta = 400;
[smpRank(:,2),VAL] = MAED(fea,xs_NUM,options);
subplot(222);
plot(fea(split,1),fea(split,2),'.k',fea(~split,1),fea(~split,2),'.b');
hold on;
for i = 1:size(smpRank,1)
  plot(fea(smpRank(i,2),1),fea(smpRank(i,2),2),'*r');	
  text(fea(smpRank(i,2),1),fea(smpRank(i,2),2),['\fontsize{16} \color{red}',num2str(i)]);
end
hold off;


th=1; pca_v=0;svm_option=[0,0,1,1];first_every_choose_num=1;end_condition=[1,xs_NUM];
options = [];
options_active=[5,2,3,0.5,400]; 
train_set_per=1; 
new_fea=fea;label=gnd;

result=EPAL_process1(mat,first_every_choose_num,svm_option,options_active,end_condition);
smpRank(:,3)=result.now_choose_serial(1:xs_NUM,1);
subplot(223);
plot(fea(split,1),fea(split,2),'.k',fea(~split,1),fea(~split,2),'.b');
hold on;
for i = 1:size(smpRank,1)
  plot(fea(smpRank(i,3),1),fea(smpRank(i,3),2),'*r');	
  text(fea(smpRank(i,3),1),fea(smpRank(i,3),2),['\fontsize{16} \color{red}',num2str(i)]);
end
hold off;

subplot(224);












sample_num=size(fea,1);
tmp=randperm(sample_num);
RS=(tmp(1:xs_NUM))';
smpRank1=[smpRank,RS];
way= svm_option(1);
type=svm_option(2);
cfhs=svm_option(3);
hhs=svm_option(4);
cfhsandhhs=[' -c ',num2str(cfhs),' -g ',num2str(hhs),' '];
options=[' -q ',' -t ',num2str(way),' -s ',num2str(type),' ',cfhsandhhs,'-b 1 '];   
[N,M]=size(smpRank1);
choose_num=2;
acc=nan(N/choose_num,M);
for i=1:(N/choose_num)
    for j=1:M
        pos=smpRank1(1:(i*choose_num),j);
        net=svmtrain(gnd(pos,:),fea(pos,:),options);
        [t,~]=svmpredict(gnd,fea,net);
        tmp=gnd-t;
        acc(i,j)=length(find(tmp==0))/length(gnd);
    end
end

subplot(224);






figure
color={'b','g','r','k'};
for i=1:size(acc,2)
    plot(((1:size(acc,1)))*2,acc(:,i),color{1,i},'LineWidth',5);
    hold on
end
legend('TED','MAED','Our','Random');
    
    
    
    


