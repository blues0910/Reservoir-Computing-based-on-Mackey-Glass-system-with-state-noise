function [w_output,tmpx]= TrainFunc(x_of_virtualnodes,y_teach,Num_of_VitualNodes)
%LNEARREGRESS 此处显示有关此函数的摘要
%   此处显示详细说明
[~,tmpj]=size(y_teach);
tmpx=zeros(tmpj,Num_of_VitualNodes);
for i=1:tmpj
    tmpx(i,:)=x_of_virtualnodes(1+Num_of_VitualNodes*(i-1):Num_of_VitualNodes*i);
end
x_MPP=pinv(tmpx);
w_output=x_MPP*y_teach';
end