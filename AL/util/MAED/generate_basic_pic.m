



function [fea,label]=generate_basic_pic(type)
addpath('E:\work\DOCTOR_WORK\ALG\matlab\各种分布');
switch type
    case 1
        data = twospirals();
    case 2
        data = clusterincluster();
    case 3
        data = corners();
    case 4
        data = halfkernel();
    case 5
        data = crescentfullmoon();
    case 6
        data = outlier();
    case 7
        data = banana();
    case 8
        data = twobayes();
    case 9
        data = twocircle();
    case 10
        data = mammography(); 
end
label_tmp=data(:,3);
if length(unique(label_tmp))>2
   label=mod(label_tmp,2);
else
   label=label_tmp;

end

fea=data(:,1:2);