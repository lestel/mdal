function average=average_score(m,method)
if strcmp(method,'CL')==1
         for i=1:size(m,1)
            for j=1:size(m,2)
                if m(i,j)<0.5
                    m(i,j)=1-m(i,j);
                end
            end
         end
end

if size(m,1)~=1
        for i=1:size(m,1)
            for j=1:size(m,2)
                if m(i,j)==min(m(:,j))
                   m(i,j)=0;
                end
            end
         end
            average=sum(m,1)/(size(m,1)-1);
else
    average=m;
end
