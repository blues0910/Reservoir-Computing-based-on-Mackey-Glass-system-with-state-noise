function [] = DrawPicOfSol(sol,Tau)
% 此处显示有关此函数的摘要
%   此处显示详细说明
t = linspace(0,Tau,10000);
y = deval(sol,t);
plot(t,y);
xlabel('t');
ylabel('y(t)');
pause(1)
end

