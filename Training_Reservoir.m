clear
profile on
%training data------------------------------------------------------
training_data=load([pwd '\生成教师数据\sample2.mat']);
I=training_data.u(1:100);
TY=training_data.y(1:100);
%Parameters--------------------------------------------------------
Tau=80;
Num_of_VitualNodes=100;
gamma=0.5;
%Mask--------------------------------------------------------
M=randi([-1 1],length(I),Num_of_VitualNodes);
%Reservoir------------------------------------------------------``--
x_of_virtualnodes = Reservior(I,Tau,Num_of_VitualNodes,gamma,M);
%Training Output Weights---------------------------------------------------
[w_output,tmpx]=TrainFunc(x_of_virtualnodes,TY,Num_of_VitualNodes);
y_trained=(tmpx*w_output)';
subplot(311)
plot(TY);
subplot(312)
plot(y_trained)
subplot(313)
plot(abs(y_trained-TY));
save([pwd '\计算结果\MaskFunc_and_OutputWeights_sample3_400nodes'],'M','w_output');
save([pwd '\计算结果\Training_Result_of_sample3_400nodes.mat']);
profile viewer