%{
input
Train训练集
Test 测试集
per  精度百分比
output
PA_rebuilt 改进训练集
PB_rebuilt 改进测试集
ycsjy_num  BP神经元个数
%}
%%
function[PA_rebuilt,PB_rebuilt]=PCAdimen_new(Tr_fea,Te_fea,num)
if num==0
PA_rebuilt=Tr_fea;
PB_rebuilt=Te_fea;
else
tezheng_num=size(Tr_fea,2);
%%---归一化
[train_re,ps] = mapminmax(Tr_fea',0,1);
test_re= mapminmax('apply',Te_fea',ps);
train_re=train_re';
test_re=test_re';

PA=train_re;
PB=test_re;
%%---归一化结束
if num>=tezheng_num
  PA_rebuilt=PA;
  PB_rebuilt=PB;
else
[a1,b1,~,~]=princomp(PA);%c1表验证情况
P0=b1(:,1:num);%%选择需求列数
PA_mean=mean(PA);
%%for i=1:4 xmean(i,:)=PA(i,:)-PA_mean;end;xmean*a1=b1还原方法
PA_rebuilt=P0;

PB_num=size(PB,1);
if PB_num==0
PB_rebuilt=[];  
else 
for i=1:PB_num 
    xmean_PB(i,:)=PB(i,:)-PA_mean;
end
    b2=xmean_PB*a1;
    P1=b2(:,1:num);
    PB_rebuilt=P1;%%新训练集
end


end
end