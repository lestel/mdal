%{
input
Trainѵ����
Test ���Լ�
per  ���Ȱٷֱ�
output
PA_rebuilt �Ľ�ѵ����
PB_rebuilt �Ľ����Լ�
ycsjy_num  BP��Ԫ����
%}
%%
function[PA_rebuilt,PB_rebuilt]=PCAdimen_new(Tr_fea,Te_fea,num)
if num==0
PA_rebuilt=Tr_fea;
PB_rebuilt=Te_fea;
else
tezheng_num=size(Tr_fea,2);
%%---��һ��
[train_re,ps] = mapminmax(Tr_fea',0,1);
test_re= mapminmax('apply',Te_fea',ps);
train_re=train_re';
test_re=test_re';

PA=train_re;
PB=test_re;
%%---��һ������
if num>=tezheng_num
  PA_rebuilt=PA;
  PB_rebuilt=PB;
else
[a1,b1,~,~]=princomp(PA);%c1����֤���
P0=b1(:,1:num);%%ѡ����������
PA_mean=mean(PA);
%%for i=1:4 xmean(i,:)=PA(i,:)-PA_mean;end;xmean*a1=b1��ԭ����
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
    PB_rebuilt=P1;%%��ѵ����
end


end
end