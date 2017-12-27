function [first_choose_serial,rest_choose_serial]=first_batch_acquire(tr_label1,first_every_choose_num)
type=unique(tr_label1);
type_num=length(type);
first_choose_serial=[];
for i=1:type_num
pos=find(tr_label1==type(i));
tmp=pos(1:min(first_every_choose_num,length(pos)),1);
first_choose_serial=[first_choose_serial;tmp];
end
serial=1:size(tr_label1,1);
rest_choose_serial=setdiff(serial,first_choose_serial);