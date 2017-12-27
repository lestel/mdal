%%
%{
%% http://cn.mathworks.com/help/stats/mnrfit.html
load carbig
X = [Acceleration Displacement Horsepower Weight];
miles = ordinal(MPG,{'1','2','3','4'},[],[9,19,29,39,48]);
[B,dev,stats] = mnrfit(X,miles,'model','ordinal');
A =[B(1:3)'; repmat(B(4:end),1,3)]
%}
clc
clear
study_range=[2,3,4,5];
study_fb=[1.5,2.5,3.5,4.5,5.5];
train_set_num=900;
inputSize = 900; % ÌØÕ÷ÊýSize of input vector (MNIST images are 28x28)  
numClasses = 4;     % Number of classes (MNIST images fall into 10 classes)  

load('HOGANDLABELFORREGURESSION.mat'); 
need_serial=[];
for i=1:size(study_range,2)
    need_serial=[need_serial;find(label==study_range(i))];
end

pos_num=length(need_serial);
tmp=need_serial(randperm(pos_num));
%%
label_new=label(tmp);
fea_new=f_hog(tmp,:);
tr=fea_new(1:train_set_num,:);
tr_label=label_new(1:train_set_num,:);
te=fea_new(train_set_num+1:end,:);
te_label=label_new(train_set_num+1:end,:);

tr1=(1:size(tr_label,1))';
te1=(1:size(te_label,1))';
[PA_rebuilt,PB_rebuilt,ycsjy_num]=PCAdimen([tr1,tr_label,tr],[te1,te_label,te],95);
tr2=PA_rebuilt(:,3:end);
te2=PB_rebuilt(:,3:end);

miles = ordinal(tr_label,{'2','3','4','5'},[],study_fb);
[B2,dev,stats] = mnrfit(tr2,miles,'model','ordinal','Link', 'probit');
[B,dev,stats] = mnrfit(tr2,miles,'model','ordinal');
%{
[B,dev,stats] = mnrfit(tr,miles,'model','ordinal',);
%}
condition_num=study_range();
A =[B(1:3)'; repmat(B(4:end),1,3)];
A2 =[B2(1:3)'; repmat(B2(4:end),1,3)];
condition_tr=zeros(size(tr2,1),size(A,2));
condition_tr2=zeros(size(tr2,1),size(A,2));
dec_te=nan(size(te2,1),1);
dec_tr=nan(size(tr2,1),1);
condition_te=zeros(size(te2,1),size(A,2));
condition_te2=zeros(size(te2,1),size(A,2));



for ii=1:size(tr2,1)
    for iii=1:size(A,2)
    condition_tr(ii,iii)=exp([1,tr2(ii,:)]*A(:,iii));
    condition_tr2(ii,iii)=exp([1,tr2(ii,:)]*A2(:,iii));

    end
    tmp=[condition_tr(ii,:),999];
    pos=find(tmp>=1);
    dec_tr(ii,1)=study_range(pos(1));
end

for ii=1:size(te2,1)
    for iii=1:size(A,2)
    condition_te(ii,iii)=exp([1,te2(ii,:)]*A(:,iii));
    condition_te2(ii,iii)=exp([1,te2(ii,:)]*A2(:,iii));

    end
    tmp=[condition_te(ii,:),999];
    pos=find(tmp>=1);
    dec_te(ii,1)=study_range(pos(1));
end
abcd_tr=convert_ctop(condition_tr);
abcd_te=convert_ctop(condition_te);

dec_te2=nan(size(te2,1),1);
dec_tr2=nan(size(tr2,1),1);
for i=1:size(te2,1)
   dec_te2(i,1)=study_range(find(abcd_te(i,:)==max(abcd_te(i,:))));

end
for i=1:size(tr2,1)
   dec_tr2(i,1)=study_range(find(abcd_tr(i,:)==max(abcd_tr(i,:))));

end
accuracy_te=length(find((dec_te2-te_label)==0))/length(dec_te2);
accuracy_tr=length(find((dec_tr2-tr_label)==0))/length(dec_tr2);

RR = corrcoef(dec_te,te_label);  
ee = dec_te-te_label; 
dat = [dec_te;te_label]'; 
ry_test = RR(1,2); % Pearson Correlation Coefficient (PCC)
abs_test = sum(abs(ee))/length(ee); % Mean Absolute Error (MAE)
mse_test = ee(:)'*ee(:)/length(ee); % Mean Square Error (MSE)
icc_test = ICC(3,'single',dat); % Intra-Class Correlation (ICC)
