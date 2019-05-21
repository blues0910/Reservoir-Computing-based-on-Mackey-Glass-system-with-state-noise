function y = Xh_Func(t)
%XH_FUNC 此处显示有关此函数的摘要
%   此处显示详细说明
global Tau tmpsol
N=1000*Tau;
tmpy=deval(tmpsol,linspace(0,Tau,N+1));
tmpt=linspace(-Tau,0,N+1);
tmp=max(tmpt-t,0);
k=find(tmp==0,1,'last');
y=tmpy(k);
%-------------------------------------------------------------------------
% global Tau tmpsol Theta
% N=1000*Tau;
% tmpy=deval(tmpsol,linspace(0,Tau,N+1));
% if t>-Tau
%     tmpt=linspace(-Tau,0,N+1);
%     tmp=min(tmpt-t,0);
%     k=find(tmp==0,1,'first')-1;
%     y=tmpy(k);
% elseif t>-Tau-Theta&&t<=-Tau
%     y=tmpy(1);
% else
%     msg = 'Error occurred in Xh_Func.';
%     error(msg)
% end
end

