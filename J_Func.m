function y= J_Func(t)
%J_FUNC 此处显示有关此函数的摘要
%   此处显示详细说明\
%------------------------------------------------------------------
global JF tmpt_J
tmp1=max(tmpt_J-t,0);
k1=find(tmp1==0,1,'last');
y=JF(k1);
%------------------------------------------------------------------
% global JF Tau Num_of_VirtualNodes
% tmpt_J=linspace(0,Tau,Num_of_VirtualNodes);
% tmp1=max(tmpt_J-t,0);
% k1=find(tmp1==0,1,'last');
% y=JF(k1);
%------------------------------------------------------------------
% global JF Tau Num_of_VitualNodes Theta
% if t<Tau
%     tmpt_J=linspace(0,Tau,Num_of_VitualNodes+1);
%     tmp1=max(tmpt_J-t,0);
%     k1=find(tmp1==0,1,'last');
%     y=JF(k1);
% elseif t<Theta+Tau
%     y=JF(end);
% else
%     msg = 'Error occurred in J_Func.';
%     error(msg)
% end
%-------------------------------------------------------------------
% global JF Tau Num_of_VitualNodes
% tmpt_J=linspace(0,Tau,Num_of_VitualNodes+1);
% 
% if t<tmpt_J(2)
%     y=JF(1);
% elseif t<tmpt_J(3)
%     y=JF(2);
% elseif t<tmpt_J(4)
%     y=JF(3);
% elseif t<tmpt_J(5)
%     y=JF(4);
% elseif t<tmpt_J(6)
%     y=JF(5);
% elseif t<tmpt_J(7)
%     y=JF(6);
% elseif t<tmpt_J(8)
%     y=JF(7);
% elseif t<tmpt_J(9)
%     y=JF(8);
% elseif t<tmpt_J(10)
%     y=JF(9);
% elseif t<tmpt_J(11)
%     y=JF(10);
% end
end