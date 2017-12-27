function [tr_fea,tr_label]=invert_fea2(tr_fea1,tr_label1,view_num)

num=length(tr_label1)/view_num;
tr_label=tr_label1(1:num,1);
tr_fea=[];
for i=1:view_num
    POS1=num*(i-1)+1;
    POS2=num*i;
    tr_fea=[tr_fea,tr_fea1(POS1:POS2,:)];
end

    