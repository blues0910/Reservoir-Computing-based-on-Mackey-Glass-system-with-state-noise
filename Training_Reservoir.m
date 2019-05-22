clear
profile on
%training data------------------------------------------------------
training_data=load([pwd '\生成教师数据\sample1.mat']);
I=training_data.u;
%Parameters--------------------------------------------------------
Tau=0.79;
Num_of_VitualNodes=100;
gamma=1;
%Mask--------------------------------------------------------
M=randi([-1 1],length(I),Num_of_VitualNodes);
%Reservoir--------------------------------------------------------
x_of_virtualnodes = Reservior(I,Tau,Num_of_VitualNodes,gamma,M);
%Training Output Weights---------------------------------------------------
[w_output,tmpx]=TrainFunc(x_of_virtualnodes,training_data.y,Num_of_VitualNodes);
y_trained=(tmpx*w_output)';
subplot(311)
plot(training_data.y);
subplot(312)
plot(y_trained)
subplot(313)
plot(abs(y_trained-training_data.y));
save('MaskFunc_and_OutputWeights_精度测试1','M','w_output');
save('精度测试1.mat');
profile viewer