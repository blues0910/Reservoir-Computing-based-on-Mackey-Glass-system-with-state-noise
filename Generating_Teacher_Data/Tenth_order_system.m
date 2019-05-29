function y0 = Tenth_order_system(u0)
%10TH_ORDER_SYSTEM 此处显示有关此函数的摘要
%   此处显示详细说明
N=length(u0);
u=[zeros(1,10) u0];
y=zeros(1,N+10);
for i=11:N
    y(i)=0.3*y(i-1)+0.05*y(i-1)*sum(y(i-10:i-1))+1.5*u(i-1)*u(i-10)+0.1;
end
y0=y(11:end);
end

