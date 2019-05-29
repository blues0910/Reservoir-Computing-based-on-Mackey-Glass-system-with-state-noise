function sol = dde_solve(ddefile,lags,xh,tspan,tmpgamma,J_t)
%DDE_SOLVE 此处显示有关此函数的摘要
%   此处显示详细说明
global gamma JF tmpy Tau tmpt Num_of_VirtualNodes tmpt_J
%------------------------------------------------------------------
tmpt_J=linspace(0,Tau,Num_of_VirtualNodes);
%------------------------------------------------------------------
gamma=tmpgamma;
JF=J_t;
% options = ddeset('RelTol',1e-5,'AbsTol',1e-8);
% options = ddeset('RelTol',1e-6,'AbsTol',1e-9);
sol=dde23(ddefile,lags,xh,tspan);
%------------------------------------------------------------------
N=10*Tau;
tmpy=deval(sol,linspace(0,Tau,N+1));
tmpt=linspace(-Tau,0,N+1);
%------------------------------------------------------------------
end

