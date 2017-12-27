clc
clear
load('passcl_R.mat');
load('passre_R.mat');
figure
plot(1:30,result.AUC(:,1),'b-','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,2),'g-','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,3),'y-','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,4),'r-','LineWidth',2.5);
hold on

plot(1:30,result.AUC(:,1),'b*','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,2),'g*','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,3),'y*','LineWidth',2.5);
hold on
plot(1:30,result.AUC(:,4),'r*','LineWidth',2.5);


legend('MLO or CC view','MLO view','CC view','MLO and CC view',4);
title('\fontsize{10}the comparison between classification from two views and single view(1)')
ylabel('AUC');
xlabel('Test ');
axis([0,31,0.8,1]);
figure
plot(1:30,result.F1measure(:,1),'b-','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,2),'g-','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,3),'y-','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,4),'r-','LineWidth',2.5);
hold on


plot(1:30,result.F1measure(:,1),'b*','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,2),'g*','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,3),'y*','LineWidth',2.5);
hold on
plot(1:30,result.F1measure(:,4),'r*','LineWidth',2.5);
hold on



legend('MLO or CC view','MLO view','CC view','MLO and CC view',4);
title('\fontsize{10}the comparison between classification from two views and single view(2)')
ylabel('F1measure');
xlabel('Test ');
axis([0,31,0.8,1]);


figure
plot(1:30,-1*diff_te(:,1),'b-','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,2),'g-','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,3),'y-','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,4),'r-','LineWidth',2.5);
hold on



plot(1:30,-1*diff_te(:,1),'b*','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,2),'g*','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,3),'y*','LineWidth',2.5);
hold on
plot(1:30,-1*diff_te(:,4),'r*','LineWidth',2.5);



legend('MLO or CC view','MLO view','CC view','MLO and CC view',4);
title('\fontsize{10}the comparison between ordinal regression from two views and single view (1)')
ylabel('Mean squared error');
xlabel('Test ');
axis([0,31,0,1.2]);
figure
plot(1:30,accuracy_te(:,1),'b-','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,2),'g-','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,3),'y-','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,4),'r-','LineWidth',2.5);
hold on



plot(1:30,accuracy_te(:,1),'b*','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,2),'g*','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,3),'y*','LineWidth',2.5);
hold on
plot(1:30,accuracy_te(:,4),'r*','LineWidth',2.5);


legend('MLO or CC view','MLO view','CC view','MLO and CC view',4);
title('\fontsize{10}the comparison between ordinal regression from two views and single view (2)')
ylabel('Testing accuracy');
xlabel('Test ');
axis([0,31,0.3,0.7]);