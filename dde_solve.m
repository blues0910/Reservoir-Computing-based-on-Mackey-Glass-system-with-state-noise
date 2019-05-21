function sol = dde_solve(ddefile,lags,xh,tspan,tmpgamma,J_t)
%DDE_SOLVE 此处显示有关此函数的摘要
%   此处显示详细说明
global gamma JF tmpsol 
gamma=tmpgamma;
JF=J_t;
options = ddeset('RelTol',1e-5,'AbsTol',1e-8);
% options = ddeset('RelTol',1e-6,'AbsTol',1e-9);
sol=dde23(ddefile,lags,xh,tspan,options);
tmpsol=sol;
end

