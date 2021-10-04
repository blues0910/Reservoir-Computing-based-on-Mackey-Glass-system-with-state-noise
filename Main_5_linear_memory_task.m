clear
Training_steps=5000;
Predicting_steps=1000;
T=Training_steps+Predicting_steps;
discarded_steps=100;
training_data=load([pwd '\Generating_Teacher_Data\5_lag_linear_memory_task.mat']);
Input_streaming=training_data.u(:,1:T);
Training_data=training_data.y(:,1:T);
%---------------------------------------------------------------------------
%Check the parameter
lag=40;
gamma=0.1;
a=0.9;
b=1;
c=1;
tstep=0.2;
%---------------------------------------------------------------------------
Num_of_VitualNodes=fix(lag/tstep);
epsilon=0.0001;
noise=0+sqrt(epsilon).*randn(Num_of_VitualNodes,T);
%---------------------------------------------------------------------------
%Optimized inputmask
InputMask=Optimized_InputMask_for_memory_tasks(lag,gamma,0,a,b,c,tstep);
%Random inputmask
% InputMask=normalized_Mask(1,Num_of_VitualNodes,size(Input_streaming,1));
%---------------------------------------------------------------------------
%Training
J=Prepocessing_of_input(Input_streaming,InputMask);
x=zeros(Num_of_VitualNodes,T);
for it=1:Training_steps
    if it==1
        x0=rand(Num_of_VitualNodes,1);
    else
        x0=x(:,it-1);
    end
    x(:,it)=update_reservior_states(lag,tstep,x0,gamma,J{it},noise(:,it),a,b,c);
end

%---------------------------------------------------------------------------
lamda=0.0000001;
%on line training
W_out=OnLine_training(x(:,discarded_steps+1:Training_steps),Training_data(:,discarded_steps+1:Training_steps),lamda);
%off line training
% W_out=Batch_training(x(:,discarded_steps+1:Training_steps),Training_data(:,discarded_steps+1:Training_steps),lamda);

%prediction
for it=Training_steps+1:T
    x0=x(:,it-1);
    x(:,it)=update_reservior_states(lag,tstep,x0,gamma,J{it},noise(:,it),a,b,c);
end

y_trained=W_out'*x(:,1:end);

result=CalcPerf(Training_data(:,Predicting_steps+1:Training_steps),y_trained(:,Predicting_steps+1:Training_steps));
nrmse=result.NRMSE;
rmse=result.RMSE;
mse=result.MSE;
fprintf(' %10.6f',nrmse);
fprintf('\n');

tmpT=Training_steps-2*Predicting_steps;
figure('name','1')
tl=linspace(0+(tmpT-1)*tstep,tstep*T,size(y_trained,2)-tmpT+1);
for i=1:size(Training_data,1)
    s=[num2str(size(Training_data,1)) '1' num2str(i)];
    subplot(s)
    hold on
    plot(tl(1:Training_steps-tmpT+1),y_trained(i,tmpT:Training_steps),'m')
    plot(tl(Training_steps-tmpT+2:end),y_trained(i,Training_steps+1:end),'r')
    plot(tl,Training_data(i,tmpT:end),'b')
    plot(linspace((Training_steps)*tstep,(Training_steps)*tstep,100),linspace(min(y_trained(i,tmpT:end)),max(y_trained(i,tmpT:end)),100),'k');
    xlabel('$t$','Interpreter','latex');
    ylabel('Output','Interpreter','latex');
    legend({'Reservoir output','Predictive output','Actual'},'Interpreter','latex')
    text(Training_steps*tstep,0,'\rightarrow Prediction')
end

% profile viewer
%---------------------------------------------------------------------------
