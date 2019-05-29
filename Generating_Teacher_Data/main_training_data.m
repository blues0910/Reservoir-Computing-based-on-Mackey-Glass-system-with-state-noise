clear
u=0+(0.5-0).*rand(1,1000);
y=Tenth_order_system(u);
subplot(311)
plot(u);
subplot(312)
plot(y);
subplot(313)
plot(u,y,'.');
save('sample2.mat')
% save('prediction1.mat')

