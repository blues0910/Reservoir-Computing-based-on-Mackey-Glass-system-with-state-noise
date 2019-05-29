function x_of_virtualnodes = Reservior(I,Input_Tau,Input_Num_of_VitualNodes,Input_gamma,M)
%RESERVIOR 此处显示有关此函数的摘要
%   此处显示详细说明
%------------------------------------------------------------------
global Tau Num_of_VirtualNodes Theta
%Parameters--------------------------------------------------------
Tau=Input_Tau;
Num_of_VirtualNodes=Input_Num_of_VitualNodes;
Theta=Tau/Num_of_VirtualNodes;
gamma=Input_gamma;
%Mask--------------------------------------------------------
J=MaskInput(I,M);
%Reservoir--------------------------------------------------------
% t=linspace(0,Tau,100);%test command
% y=[];%test command
x_of_virtualnodes=zeros(1,Num_of_VirtualNodes*length(J));
xh0=1;
for i=1:length(J)
    if i==1
        sol=dde_solve('TDE_with_input',Tau,xh0,[0,Tau],gamma,J{i});
        x_of_virtualnodes(1:Num_of_VirtualNodes)=virtualnodes(sol,Num_of_VirtualNodes,Tau,Theta,Theta/100);
%         y=[y deval(sol,t)];%test command
    else
        sol=dde_solve('TDE_with_input',Tau,'Xh_Func',[0,Tau],gamma,J{i});
        x_of_virtualnodes(1+Num_of_VirtualNodes*(i-1):Num_of_VirtualNodes*i)=virtualnodes(sol,Num_of_VirtualNodes,Tau,Theta,Theta/100);
%         y=[y deval(sol,t)];%test command
    end
    if mod(i,100)==0
        disp(i) %test command
    end
end
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
end

