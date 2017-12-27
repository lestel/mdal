function draw_line(R,c,smooth_th,CLorOR)
color={[0,0,0],...      %ºÚ
       [255,255,0]/255,...%»Æ
       [255,0,255]/255,...%·Û
       [0,0,255]/255,...%À¶
       [0,255,0]/255,...%ÂÌ
       [0,255,255]/255,...%Çà
       [255,0,0]/255,...%ºì
       [160,32,240]/255,...%×Ï       
       [255,128,0]/255, ...%éÙ
       [0,255,255]/255,...%Çà
       [135,51,36]/255,...%¿§ 
       [192,192,192]/255 ...%»Ò
       };
   
for i=1:size(R,1);
        eval(['all_result=R{i,1}.',c,';']);
        lines_new=smooth_line1(all_result,smooth_th,CLorOR);
        plot(lines_new,'color',color{i},'LineWidth',3);
        hold on 
       
end