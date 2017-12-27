function result_show1(all_result,label_cost,AL_th,smooth_th,CLorOR)
name={'Random','MC1','MC2','MC3'};
color={[0,0,0],...      %ºÚ
       [255,255,0]/255,...%»Æ
       [255,0,255]/255,...%·Û
       [0,0,255]/255,...%À¶
       [0,255,0]/255,...%ÂÌ
       [0,255,255]/255,...%Çà
       [255,0,0]/255,...%ºì
       [160,32,240]/255,...%×Ï
       [0,255,255]/255,...%Çà
       [135,51,36]/255,...%¿§ 
       [255,128,0]/255, ...%éÙ
       [192,192,192]/255 ...%»Ò
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
   
   