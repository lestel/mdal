function [test_result,accuracy_te,deci_block]=ortest_muliteview(te_fea,te_label,net_block)
         view_num=size(net_block,1);
         each_view_fea_num=size(te_fea,2)/view_num;
         sample_number_in_everyview=length(te_label);
         deci_block=nan(sample_number_in_everyview,size(net_block,1));
         test_result_block=nan(sample_number_in_everyview,size(net_block,1));
         for i=1:view_num
              st=(i-1)*each_view_fea_num+1;
              en=i*each_view_fea_num;
              [test_result_block(:,i),~,abcd_te]=ordinalregression_test2(te_fea(:,st:en),te_label,net_block{i,1});
              for ii=1:size(abcd_te,1)
                  tmp=abcd_te(ii,:);
                  tmp2=sort(tmp,'descend');
                  deci_block(ii,i)=tmp2(1)-tmp2(2);
              end
         end
         deci_block1=abs(deci_block);
         test_result=nan(sample_number_in_everyview,1);
         for ii=1:sample_number_in_everyview
             pos=find(deci_block1(ii,:)==max(deci_block1(ii,:)));
             test_result(ii,1)=test_result_block(ii,pos(1));
         end
         
         accuracy_te=length(find((test_result-te_label)==0))/length(te_label);