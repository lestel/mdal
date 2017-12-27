function whether_end=endornot_judge(train_set,rest_part_train_sample_ind1,choose_num,accuray,end_condition)
condition=end_condition(1);
input=end_condition(2);

all_sample_num=size(train_set,1);
rest_sample_num=length(rest_part_train_sample_ind1);
if rest_sample_num<choose_num
   whether_end=1;
else
    whether_end=0;
   switch condition
       case 0
            whether_end=0;
   case 1  %数量
       if input<=(all_sample_num-rest_sample_num)
          whether_end=1;
           
       end
   case 2  %百分比
       if input*all_sample_num<=(all_sample_num-rest_sample_num)
          whether_end=1;
       end 
    case 3 %准确率
       if input<=accuray
          whether_end=1;
       end 
   end
end