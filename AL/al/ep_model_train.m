function al_array=ep_model_train(tr,view_num,TEDorMAED)

   option.KernelType = 'PolyPlus';
   option.t=0.5;
   if strcmp(TEDorMAED,'TED')==1
   option.ReguBeta=0;
   elseif strcmp(TEDorMAED,'MAED')==1
   option.ReguBeta=400;
   end
   VAL_list=0;
   for i=1:view_num
   st=size(tr,2)/view_num*(i-1)+1;
   en=size(tr,2)/view_num*i;
   [diff_pos_tmp_1,VAL_tmp_1] = MAED(tr(:,st:en),size(tr,1),option);
   [~,p1]=sort(diff_pos_tmp_1,'ascend');
   VAL_list=VAL_list+VAL_tmp_1(p1,1)/view_num;
   end
   al_array=VAL_list;
   
   
   %{
   st=[1,size(tr,2)/view_num+1];
   en=[size(tr,2)/view_num,size(tr,2)];
   [diff_pos_tmp_1,VAL_tmp_1] = MAED(tr(:,st(1):en(1)),size(tr,1),option);
   [diff_pos_tmp_2,VAL_tmp_2] = MAED(tr(:,st(2):en(2)),size(tr,1),option);

   [~,p1]=sort(diff_pos_tmp_1,'ascend');
   [~,p2]=sort(diff_pos_tmp_2,'ascend');
   VAL_list=(VAL_tmp_1(p1,1)+VAL_tmp_2(p2,1))/2;
   al_array=VAL_list;
   %}
   