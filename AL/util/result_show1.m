function result_show1(all_result,label_cost,AL_th,smooth_th,CLorOR)
name={'Random','MC1','MC2','MC3'};
color={[0,0,0],...      %��
       [255,255,0]/255,...%��
       [255,0,255]/255,...%��
       [0,0,255]/255,...%��
       [0,255,0]/255,...%��
       [0,255,255]/255,...%��
       [255,0,0]/255,...%��
       [160,32,240]/255,...%��
       [0,255,255]/255,...%��
       [135,51,36]/255,...%�� 
       [255,128,0]/255, ...%��
       [192,192,192]/255 ...%��
       };
   for i=1:length(AL_th)
        lines_new=smooth_line1(all_result(i,:),smooth_th,CLorOR);
        plot(label_cost,lines_new,'color',color{AL_th(i)},'LineWidth',3);
        hold on 
       
   end
   name_j='legend(';
   for i=1:length(AL_th)
      if i~=length(AL_th)
      name_j=[name_j,'''',name{AL_th(i)},''','];
      else
      name_j=[name_j,'''',name{AL_th(i)},''',4)'];
      end
   end
%eval(name_j);
eval(name_j);
   
   