function [tr,te]=random_generate(fea,label,train_per)
train_serial1=[];
test_serial1=[];
type=unique(label);
for i=1:length(type)
pp1=find(label==type(i));
pp1_num=length(pp1);
pp1_tr_num=round(train_per*pp1_num);
qq1=randperm(pp1_num);
tr_pos=pp1(qq1(1:pp1_tr_num));
te_pos=pp1(qq1(pp1_tr_num+1:end));
train_serial1=[train_serial1;tr_pos];
test_serial1=[test_serial1;te_pos];
end

tr_fea=fea(train_serial1,:);
te_fea=fea(test_serial1,:);

tr_label=label(train_serial1,1);
te_label=label(test_serial1,1);


tr.fea=tr_fea;
te.fea=te_fea;

tr.label=tr_label;
te.label=te_label;



