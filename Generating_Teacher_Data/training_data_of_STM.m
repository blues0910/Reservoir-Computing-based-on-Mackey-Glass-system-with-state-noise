clear
T=200;
tau=[2];
theta=5;
x=-1+(1-(-1)).*rand(1,2000);
y=cell(1,length(tau));
for i=1:length(x)
    xx(1+theta*(i-1):theta*i)=x(i);
end
u=xx(1+tau(end):T+tau(end));
for k=1:length(tau)
    y{k}=xx(1+tau(end)-tau(k):T+tau(end)-tau(k));
end
subplot(311)
plot(u);
subplot(312)
for i=1:length(tau)
    plot(y{i});
    hold on
end
subplot(313)
for i=1:length(tau)
    plot(u(1:end-tau(i))-y{i}(1+tau(i):end));
    hold on
end
save(['sample3_STM_delay.mat'],'u','y','tau')
% save('prediction1.mat')