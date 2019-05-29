function [d] = Determination_Coefficient(u,y,y_hat)
%DETERMINATION_COEFFICIENT 此处显示有关此函数的摘要
%   此处显示详细说明
c=cov(y,y_hat);
std1=std(u);
std2=std(y_hat);
d=c(1,2)^2/(std1*std2)^2;
end

