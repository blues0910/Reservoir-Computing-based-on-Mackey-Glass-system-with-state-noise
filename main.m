clear
profile on
% I=[1 3 2 4 2 3 4 2 1 3 4];%test command
% T=50;%test command
% I=linspace(0,0,T);%test command
%training data------------------------------------------------------
training_data=load('E:\Dropbox\Workplace\Time-Delay Reservoir\生成教师数据\sample1.mat');
I=training_data.u;
%------------------------------------------------------------------
global Tau Num_of_VitualNodes Theta
%Parameters--------------------------------------------------------
Tau=0.79;
Num_of_VitualNodes=100;
Theta=Tau/Num_of_VitualNodes;
gamma=1;
%Mask--------------------------------------------------------
J=MaskInput(I,Num_of_VitualNodes);
%Reservoir--------------------------------------------------------
% t=linspace(0,Tau,100);%test command
% y=[];%test command
x_of_virtualnodes=[];
xh0=19.001;
for i=1:length(J)
    if i==1
        sol=dde_solve('TDE_with_input',Tau,xh0,[0,Tau],gamma,J{i});
        x_of_virtualnodes=virtualnodes(sol,Num_of_VitualNodes,Tau,Theta,Theta/100);
%         y=[y deval(sol,t)];%test command
    else
        sol=dde_solve('TDE_with_input',Tau,'Xh_Func',[0,Tau],gamma,J{i});
        x_of_virtualnodes=[x_of_virtualnodes virtualnodes(sol,Num_of_VitualNodes,Tau,Theta,Theta/100)];
%         y=[y deval(sol,t)];%test command
    end    
    disp(i) %test command
end
%Output Weights---------------------------------------------------
[w_output,tmpx]=TrainFunc(x_of_virtualnodes,training_data.y,Num_of_VitualNodes);
y_trained=(tmpx*w_output)';
subplot(311)
plot(training_data.y);
subplot(312)
plot(y_trained)
subplot(313)
plot(abs(y_trained-training_data.y));
profile viewer
%test output-------------------------------------------------------------
% plot(y_output);
%test sol----------------------------------------------------------------
% ttest=linspace(0,T*Tau,T*100);
% subplot(311)
% plot(ttest,y);
% subplot(312)
% options = ddeset('RelTol',1e-7,'AbsTol',1e-11);
% soltest=dde23('Time_Delay_Equation',Tau,xh0,[0,T*Tau],options);
% ytest= deval(soltest,ttest);
% plot(ttest,ytest);
% subplot(313)
% plot(ttest,abs(y-ytest)./y);
% ylim([0 1])
%test mask--------------------------------------------------------
% Num_plot=1000;
% [tmpi,tmpj]=size(I);
% T=tmpj*Tau;
% Num=tmpj*Num_plot;
% t=linspace(0,T,Num);
% tmpI=ones(tmpi,Num);
% for i=1:tmpi
%     for j=1:tmpj
%         tmpI(i,1+Num_plot*(j-1):Num_plot*j)=I(i,j);
%     end
% end
% subplot(211)
% for i=1:tmpi
% plot(t,tmpI(i,:));
% hold on
% end
% subplot(212)
% tmpJ=zeros(tmpj,Num_plot);
% Num_plot2=Num_plot/Num_of_VitualNodes;
% for i=1:tmpj
%     for j=1:Num_of_VitualNodes
%         tmpJ(i,1+Num_plot2*(j-1):Num_plot2*j)=J{i}(j);
%     end
% end
% plotJ=[];
% for k=1:tmpj
%     plotJ=[plotJ tmpJ(k,:)];
% end
% plot(t,plotJ);