clear
profile on
%Parameters--------------------------------------------------------
% Tau=80;
Tau=80;
Num_of_VitualNodes=20;
OutputNodes=4;
gamma=0.01;
discarded_steps=500;
%Training Reservoir----------------------------------------------------------------------------------------
%training data------------------------------------------------------
training_data=load([pwd '\Generating_Teacher_Data\sample2_STM_delay.mat']);
I=training_data.u;
%Mask--------------------------------------------------------
M=-1+(1-(-1)).*rand(length(I),Num_of_VitualNodes);
%Reservoir--------------------------------------------------------
x_of_virtualnodes = Reservior(I,Tau,Num_of_VitualNodes,gamma,M);
xx=ArrangeFunc(x_of_virtualnodes,length(I),Num_of_VitualNodes);
%Training Output Weights---------------------------------------------------
W_output=cell(1,OutputNodes);
TY=cell(1,OutputNodes);
y_trained=cell(1,OutputNodes);
nrmse=zeros(1,OutputNodes);
STM_Coef=zeros(1,OutputNodes);
for i=1:OutputNodes
    TY{i}=training_data.y{i};
    W_output{i}=TrainFunc(xx(discarded_steps:end,:),TY{i}(discarded_steps:end),Num_of_VitualNodes);
    y_trained{i}=(xx*W_output{i})';
    nrmse(i)=NRMSE(TY{i},y_trained{i});
    STM_Coef(i)=Determination_Coefficient(I,TY{i},y_trained{i});
end
%Plots--------------------------------------s-----------------------------------------------------------
if OutputNodes>4
    S=zeros(1,4);
    S(1)=1;
    S(2)=find(STM_Coef>=0.5,1,'last');
    S(3)=find(STM_Coef>=0.25,1,'last');
    S(4)=find(STM_Coef>=0.1,1,'last');
else
    S=1:1:OutputNodes;
end
figure('Name',['Testing the trained delay network for delays ' num2str(S)])
for i=1:length(S)
    tmp=length(S)*100+10+i;
    subplot(tmp)
    plot(TY{S(i)},'r');
    hold on
    plot(y_trained{S(i)},'b');
    legend({'$y$','$\hat{y}$'},'Interpreter','Latex')
    title(['Delay=' num2str(training_data.tau(S(i))) ...
        ', NRMSE=' num2str(nrmse(S(i))) ...
        ', The ' num2str(S(i)) '-delay STM capacity=' num2str(STM_Coef(S(i)))])
end

figure('Name','The forgetting curve of the trained network')
plot(STM_Coef)

ss=['The STM capacity of the network is ' num2str(sum(STM_Coef))];%test code
disp(ss)%test code
% save([pwd '\Results\MaskFunc_and_OutputWeights_test_100nodes'],'W_inputweights','W','W_output');
% save([pwd '\Results\Training_Result_of_test_100nodes.mat']);
%-----------------------------------------------------------------------------------------------
% [w_output,tmpx]=TrainFunc(x_of_virtualnodes,TY,Num_of_VitualNodes);%test code
% y_trained=(tmpx*w_output)';%test code
% disp(NRMSE(TY,y_trained));%test code
% subplot(311)%test code
% plot(TY);%test code
% subplot(312)%test code
% plot(y_trained)%test code
% subplot(313)%test code
% plot(abs(y_trained-TY));%test code
% save([pwd '\计算结果\MaskFunc_and_OutputWeights_test_100nodes'],'M','w_output');
% save([pwd '\计算结果\Training_Result_of_test_100nodes.mat']);
%--------------------------------------------------------------------------------------------
%Test Reservoir--------------------------------------------------------------------------------------------
%test prediction---------------------------------------------------------------
% traindata=load([pwd '\生成教师数据\sample1.mat']);
% testdata=load([pwd '\生成教师数据\prediction1.mat']);
% I=[traindata.u testdata.u(1:200)];
% % %Parameters--------------------------------------------------------
% % Tau=80;
% % Num_of_VitualNodes=00;
% % gamma=0.5;
% %Load MaskFunc and OutputWeights-------------------------------------------
% load([pwd '\MaskFunc_and_OutputWeights_精度测试1']);
% %Mask--------------------------------------------------------
% J=MaskInput(I,M);
% %Reservoir--------------------------------------------------------
% x_of_virtualnodes = Reservior(I,Tau,Num_of_VitualNodes,gamma,M);
% %Load output weights-------------------------------------------------------
% tmpx=ArrangeFunc(x_of_virtualnodes,length(I),Num_of_VitualNodes);
% y_output=(tmpx*w_output)';
% subplot(311)
% plot([traindata.y testdata.y(1:100)]);
% subplot(312)
% plot(y_output)
% subplot(313)
% plot(abs(y_output-[traindata.y testdata.y(1:100)]));
profile viewer
