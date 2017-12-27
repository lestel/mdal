function query_index = QUIRE(K,Lindex,Uindex,label,lambda)
%QUIRE: Active Learning by Querying Informative and Representative Examples
%
%    Syntax
%       query_index=QUIRE(K,Lindex,Uindex,label,lambda)
%    
%    Description
%       Suppose there is a data set D with n instances, n1 of them are labeled (queried) and the others are unlabeled. The i-th instance is stored in D(i,:)
%       QUIRE takes,
%           K           - A n x n array, the kernel matrix of the data set D
%           Lindex      - A 1 x n1 vector, the index of labeled instances
%           Uindex      - A 1 x (n-n1) vector, the index of unlabeled instances
%           label       - A n1 x 1 vector, label(i) is the class label of D(Lindex(i),:), 1 for positive class and -1 for negative class
%           lambda      - the parameter lambda in Eq.5 in [1]

%      and returns,
%           query_index - An integer, the index of the selected instance for query, i.e., the label of D(query_index,:) is to be queried
%           
% [1] S.-J. Huang, R. Jin, and Z.-H. Zhou. Active learning by querying informative and representative examples. In: Advances in Neural Information Processing Systems 24 (NIPS'10), Vancouver, Canada, 2010.


    % calculate L
    KK=K([Lindex,Uindex],[Lindex,Uindex]);
    L=inv(KK+eye(size(KK,1))./lambda);

    % calculate the evaluation value for each instance in the pool of unlabeled data according to Eq.(9) in [1]
    etas=cal_eta(label,L);

    % select the s^* which lead to minimal evaluation 
    [minval,s]=sort(etas);
    query_index=Uindex(s(1));
    