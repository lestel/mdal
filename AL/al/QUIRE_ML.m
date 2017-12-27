function idx_selected=QUIRE_ML(K,Y,Sidx,Uidx,lambda)
% assume we have n instances (including labeled and unlabeled) and m labels
% K : a n*n matrix, the kernel matrix of the data set
% Y : a n*m matrix, the label matrix of all data, but only the elements of labeled data are used
% Sidx : the index of labeled instance-label pairs, the pair of i-th instance and j-th label is indexed by i+(j-1)*m
% Uidx : the index of unlabeled instance-label pairs
% lambda : the parameter lambda in Eq.12 in [1]

% idx_selected : an integer, the index of the selected instance-label pair

% [1] S.-J. Huang, R. Jin, and Z.-H. Zhou. Active learning by querying informative and representative examples. IEEE Transactions on Pattern Analysis and Machine Intelligence.

[n,m]=size(Y);

% calculate the matrix L
if(~exist('R','var'))
    R=eye(m);
    L=kron(sparse(R),sparse(inv(K+lambda*eye(n))));
else % R is a m*m matrix, the correlation matrix among labels (optional)
    tmp=sort(R(:),'descend');
    tmp=tmp(round(m*2));
    R(R<tmp)=0;
    [R1,R2]=eig(R);
    R1=sparse(R1);R2=sparse(R2);
    [K1,K2]=eig(K);
    K1=sparse(K1);K2=sparse(K2);
    tmp=lambda*speye(n*m)+kron(R2,K2);
    tmp(tmp~=0)=1./tmp(tmp~=0);
    L=kron(R1,K1)*tmp*kron(inv(R1),inv(K1));
end

Uidx=Uidx(randperm(length(Uidx),min(m*2,length(Uidx))));
Sidx=sort(Sidx);
Uidx=sort(Uidx);
nU=length(Uidx);

Ys=Y(:);
Ys=Ys(Sidx,1)';

Luu=L(Uidx,Uidx);
Lsu=L(Sidx,Uidx);
LL=inv(Luu);
% calculate the evaluation value for each pair in U
vals=zeros(nU,1);
YsLsu=Ys*Lsu;
for i=1:nU
    tmpidx=[1:i-1,i+1:nU];
    Lqq=Luu(i,i);
    Lqr=Luu(i,tmpidx);
    tmp0=Lqq;%+Ys'*Lss*Ys;
    
    b=-(LL(i,tmpidx));
    invLrr=LL(tmpidx,tmpidx)-(b'*b./LL(i,i));
    vt1=YsLsu(:,tmpidx);
    vt2=2*YsLsu(:,i);
    tmp1=vt1+Lqr;
    tmp1=vt2-tmp1*invLrr*tmp1';
    tmp2=vt1-Lqr;
    tmp2=-vt2-tmp2*invLrr*tmp2';
    vals(i)=max((tmp0+tmp1),(tmp0+tmp2));
    %valsall(i,:)=[1/(lambda+R(b,b)*K(a,a)),(lambda+R(b,b)*K(a,a))^(-2)*(RKab'*M*RKab),Ys'*M*Ys,abs(tmp2)];
    %lambda*[tmp1-2*tmp2,tmp1+2*tmp2]
end
idx_selected=find(vals==min(vals));
idx_selected=idx_selected(randi(length(idx_selected)));
idx_selected=Uidx(idx_selected);
end
