function v = TDE_with_input(t,y,Z)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
tmp1=J_Func(t);
tmp2=Z+tmp1;
% v = 2.*tmp2./(1+tmp2.^9.65)-y;
v=Time_Delay_Equation(t,y,tmp2);
if ~(isreal(v))
    msg = 'Error occurred in Time_Delay_Equation.m. The output is a complex number.';
    error(msg)   
end
end

