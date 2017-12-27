function abcd=convert_ctop(data)
abcd=nan(size(data,1),4);

for i=1:size(data,1)
    L=data(i,1);M=data(i,2);N=data(i,3);
    abcd(i,1)=L/(L+1);
    abcd(i,2)=(M-L)/(1+M)/(L+1);
    abcd(i,3)=1/(M+1)-1/(N+1);
    abcd(i,4)=1/(N+1);
end

