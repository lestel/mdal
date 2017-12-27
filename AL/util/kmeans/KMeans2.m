%N������һ���ֶ�����
%data������Ĳ��������ŵ�����
%u��ÿһ�������
%re�Ƿ��صĴ������ŵ�����
function [u,re]=KMeans2(data,int_pos,label)   
    [m,n]=size(data);   %m�����ݸ�����n������ά��
    ma=zeros(n);        %ÿһά������
    mi=zeros(n);        %ÿһά��С����
    label_type=unique(label);
    N=length(label_type); 
    u=zeros(N,n); %�����ʼ�������յ�����ÿһ�������λ��
    for i=1:N
        pos=find(label==label_type(i));
        one_fea=int_pos(pos,:);
        u(i,:)=mean(one_fea,1);
    end
   
   
    iter=1;
    while(iter<5)
        pre_u=u;            %��һ����õ�����λ��
        for i=1:N
            tmp{i}=[];      % ��ʽһ�е�x(i)-uj,Ϊ��ʽһʵ����׼��
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
        
        quan=zeros(m,N);
        for i=1:m        %��ʽһ��ʵ��
            c=[];
            for j=1:N
                c=[c norm(tmp{j}(i,:))];
            end
            [junk,index]=min(c);
            quan(i,index)=norm(tmp{index}(i,:));           
        end
        
        for i=1:N            %��ʽ����ʵ��
           for j=1:n
                u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
           end           
        end
        
        if norm(pre_u-u)<0.1  %���ϵ���ֱ��λ�ò��ٱ仯
            break;
        end
        iter=iter+1;
    end
    
    re=[];
    for i=1:m
        tmp=[];
        for j=1:N
            tmp=[tmp norm(data(i,:)-u(j,:))];
        end
        [junk,index]=min(tmp);
        re=[re;data(i,:) index];
    end
