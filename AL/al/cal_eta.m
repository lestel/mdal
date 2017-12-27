function etas=cal_eta(Yl,L)

% Yl        A numL*1 array stores the labels of the labeled data
% L         A n*n array, L=inv(K+eye(size(K,1))./lambda), where K is the kernel matrix, the first numL rows and columns are corresponding to the labeled data
% etas      A numU*1 array, etas(i) is the evaluation value of the i-th unlabeled instance

numL=size(Yl,1);
n=size(L,1);
numU=n-numL;
indexL=1:numL;
indexU=(numL+1):n; 

% calculate the inverse of L(a,a)
LL=inv(L(indexU,indexU));

etas=zeros(numU,1);
for i=1:numU
    % calculate the evaluation value according to Eq.(9)
    indexS=i+numL;
    indexU=(numL+1):n;
    indexU(i)=[];
    tmpindex=indexU-numL;
    a=LL(i,i);
    b=-(LL(i,tmpindex));
    D=LL(tmpindex,tmpindex);
    V=D-(b'*b./a);
    
    Lul=L(indexU,indexL);
    Lus=L(indexU,indexS);
    Lsl=L(indexS,indexL);
    Lss=L(indexS,indexS);

    t1=Lul*Yl;
    t3=t1'*V;
    t4=t3*Lus;
    t5=2*Lsl*Yl-(t4+t4');
    t6=Lss-t3*t1-Lus'*V*Lus;
    
    eta1=t6+t5; % y_s=1
    eta2=t6-t5; % y_s=-1    
    % select the worst case
    etas(i,1)=max(eta1,eta2);    
end
