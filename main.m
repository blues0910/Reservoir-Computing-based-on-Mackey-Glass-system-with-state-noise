clear
profile on
%test prediction---------------------------------------------------------------
testdata=load([pwd '\生成教师数据\prediction1.mat']);
I=testdata.u;
%Parameters--------------------------------------------------------
Tau=0.79;
Num_of_VitualNodes=100;
gamma=1;
%Load MaskFunc and OutputWeights-------------------------------------------
load([pwd '\MaskFunc_and_OutputWeights_精度测试1']);
%Mask--------------------------------------------------------
J=MaskInput(I,M);
%Reservoir--------------------------------------------------------
x_of_virtualnodes = Reservior(I,Tau,Num_of_VitualNodes,gamma,M);
%Load output weights-------------------------------------------------------
tmpx=ArrangeFunc(x_of_virtualnodes,length(I),Num_of_VitualNodes);
y_output=(tmpx*w_output)';
subplot(311)
plot(testdata.y);
subplot(312)
plot(y_output)
subplot(313)
plot(abs(y_output-testdata.y));
profile viewer
