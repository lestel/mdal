%N是数据一共分多少类
%data是输入的不带分类标号的数据
%u是每一类的中心
%re是返回的带分类标号的数据
function [u,re]=KMeans2(data,int_pos,label)   
    [m,n]=size(data);   %m是数据个数，n是数据维数
    ma=zeros(n);        %每一维最大的数
    mi=zeros(n);        %每一维最小的数
    label_type=unique(label);
    N=length(label_type); 
    u=zeros(N,n); %随机初始化，最终迭代到每一类的中心位置
    for i=1:N
        pos=find(label==label_type(i));
        one_fea=int_pos(pos,:);
        u(i,:)=mean(one_fea,1);
    end
   
   
    iter=1;
    while(iter<5)
        pre_u=u;            %上一次求得的中心位置
        for i=1:N
            tmp{i}=[];      % 公式一中的x(i)-uj,为公式一实现做准备
            for j=1:m
                tmp{i}=[tmp{i};data(j,:)-u(i,:)];
            end
        end
        
        quan=zeros(m,N);
        for i=1:m        %公式一的实现
            c=[];
            for j=1:N
                c=[c norm(tmp{j}(i,:))];
            end
            [junk,index]=min(c);
            quan(i,index)=norm(tmp{index}(i,:));           
        end
        
        for i=1:N            %公式二的实现
           for j=1:n
                u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
           end           
        end
        
        if norm(pre_u-u)<0.1  %不断迭代直到位置不再变化
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
