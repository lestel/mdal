%{
lines=[0.652173913043478,0.700000000000000,0.347826086956522,0.669565217391304,0.347826086956522,0.591304347826087,0.660869565217391,0.652173913043478,0.652173913043478,0.652173913043478,0.682608695652174,0.652173913043478,0.656521739130435,0.652173913043478,0.669565217391304,0.652173913043478,0.652173913043478,0.652173913043478,0.673913043478261,0.617391304347826,0.439130434782609,0.373913043478261,0.426086956521739,0.560869565217391,0.665217391304348,0.673913043478261,0.660869565217391,0.695652173913044,0.656521739130435,0.695652173913044,0.695652173913044,0.695652173913044,0.700000000000000,0.704347826086957,0.691304347826087,0.717391304347826,0.673913043478261,0.652173913043478,0.678260869565217,0.717391304347826,0.691304347826087,0.721739130434783,0.686956521739131,0.660869565217391,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.652173913043478,0.660869565217391,0.652173913043478,0.652173913043478,0.652173913043478,0.656521739130435,0.713043478260870,0.726086956521739,0.743478260869565,0.730434782608696,0.713043478260870,0.730434782608696,0.700000000000000,0.743478260869565,0.717391304347826,0.747826086956522,0.726086956521739,0.752173913043478,0.726086956521739,0.730434782608696,0.691304347826087,0.721739130434783,0.734782608695652,0.730434782608696,0.682608695652174,0.647826086956522,0.682608695652174,0.713043478260870,0.700000000000000,0.647826086956522,0.700000000000000,0.726086956521739,0.686956521739131,0.686956521739131,0.713043478260870,0.730434782608696,0.752173913043478,0.739130434782609,0.730434782608696,0.669565217391304,0.656521739130435,0.647826086956522,0.660869565217391,0.647826086956522];
num=0.0045
lines_new=smooth_line(lines,20,num);
plot(lines_new,'r');
hold on
lines_new=smooth_line(lines,0,num);
plot(lines_new)

%}
function lines_new=smooth_line1(lines,th,CLorOR)

if strcmp(CLorOR,'CL')==1
lines(lines<0.5)=1-lines(lines<0.5);
end

if th==0
lines_new=lines;
else
    
%{
diff_min=min(abs(1/num));
R = normrnd(0,diff_min/8,1,size(lines,2));
%}
    
for i=1:th    
lines=smooth(lines);
end
%







%lines_new=lines'+R;
lines_new=lines;
    
    
    
    
    
    
%{
lines_new=lines;
for j=1:th
lines=lines_new;
for i=2:length(lines)-1
    if lines(1,i)<=lines(1,i-1)||lines(1,i)<=lines(1,i+1)
       lines_new(1,i)=(lines(1,i-1)+lines(1,i+1))/2;
    end
end
end
%}
end
