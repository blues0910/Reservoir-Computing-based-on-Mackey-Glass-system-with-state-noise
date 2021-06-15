function [InputMask] = Optimized_InputMask_for_memory_tasks(lag,gamma,x,a,b,c,tstep)
%OPTIMIZED_INPUTMASK_OF_MEMORY_TASKS 此处显示有关此函数的摘要
%   此处显示详细说明
[MC,FMC,Js] = Fisher_memory(1000,lag,gamma,0.01,x,a,b,c,tstep);
[V,D]=eig(Js);
V=real(V);
D=real(D);
[i,j]=find(D==max(max(D)));
InputMask=V(:,i);
end

