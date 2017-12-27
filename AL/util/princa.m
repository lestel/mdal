function [V,S,E]=princa(X)
[m,n]=size(X); %����������m����n
 
%-------------��һ������׼������-----------------%
mv=mean(X); %����������ľ�ֵ
st=std(X); %����������ı�׼��
X=(X-repmat(mv,m,1))./repmat(st,m,1); %��׼������X
 
%-------------�ڶ������������ϵ������-----------------%
% R1=X'*X/(m-1); %����һ��Э���������㹫ʽ
% R2=cov(X);???? %��������Э���������㺯��
R=corrcoef(X); %�����������ϵ��������
 
%-------------��������������������������ֵ-----------------%
[V,D]=eig(R);  %�������R��������������V������ֵ����D,����ֵ��С����
V=(rot90(V))';  %��������������V�Ӵ�С����
D=rot90(rot90(D));  %������ֵ�����ɴ�С����
E=diag(D);  %������ֵ����ת��Ϊ����ֵ����
 
%-------------���Ĳ������㹱���ʺ��ۼƹ�����-----------------%
ratio=0; %�ۼƹ�����
for k=1:n
 r=E(k)/sum(E);  %��k���ɷݹ�����
 ratio=ratio+r;  %�ۼƹ�����
 if(ratio>=0.9)  %ȡ�ۼƹ����ʴ��ڵ���90%�����ɷ�
 break;
 end
end
 
%-------------���岽������÷�-----------------%
S=X*V;