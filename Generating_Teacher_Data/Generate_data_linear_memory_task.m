function [ ] = Generate_data_linear_memory_task(L,T)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
% L=[0.2 0.3 0.3 0.3 0.3 0.5];
% T=10000;
tmpu=normrnd(0,1,[1,T+length(L)-1]);
y=zeros(1,T);
for i=1:T
    y(i)=L*tmpu(1+i-1:length(L)+i-1)';
end
u=tmpu(length(L):end);
save('5_lag_linear_memory_task.mat','u','y','L')
end

