clear
Tau=10;
Xh=19.001;
TS=0;
TE=50;
options = ddeset('RelTol',1e-7,'AbsTol',1e-11);
sol = dde23('Time_Delay_Equation',Tau,Xh,[TS,TE],options);
t = linspace(TS,TE,TE*100);

y = deval(sol,t);
plot(t,y);

% ylag = deval(sol,t - Tau);
% plot(y,ylag);
% title('Figure 2. Example 5 of Wille''and Baker.')
% xlabel('y(t)');
% ylabel('y(t-2)');
% axis([0 1.5 0 1.5])
%---------------------------------------------------------------------
% x=[1 2 4 2 4 3 2 1 4 5];
% y=[9 5 6 7 4 3 4 5 6 7];
% tmpx=pinv(x);
% w=tmpx*y;
% tmpy=x*w;