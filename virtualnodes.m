function x = virtualnodes(sol,Num_of_VitualNodes,Tau,Theta,epsilon)
%VITUALNODES 此处显示有关此函数的摘要
%   此处显示详细说明
if epsilon<Theta
    x=zeros(1,Num_of_VitualNodes);
    for i=1:Num_of_VitualNodes
        x(i)=deval(sol,Tau-(Num_of_VitualNodes-i)*Theta-epsilon);
    end
else
    msg='Error occurred in vitualnodes.m . Epsilon is not smaller than Theta.';
    error(msg);
end
end
 
