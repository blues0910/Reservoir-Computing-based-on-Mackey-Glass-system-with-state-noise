clear
%Parameter setting
tau=80;
gamma=1;
a=0.9;
b=1;
c=1;
tstep=0.2;
T=10000;
discarded_steps=500;
Num_of_VitualNodes=fix(tau/tstep);

%Load training dataset
training_data=load([pwd '\Generating_Teacher_Data\5_lag_linear_memory_task.mat']);
InputStream=training_data.u(:,1:T);

%Generate noise
epsilon=0;
zt=normrnd(0,epsilon,[Num_of_VitualNodes,T]);

%Optimized input mask by using spatial Fisher memory matrix
M_Optimized=Optimized_InputMask_for_memory_tasks(tau,gamma,0,a,b,c,tstep);

%Generate 1000 random input masks whose elements follow a [-var,var] uniform distribution
var=1;
M_random=-var+(var-(-var)).*rand(Num_of_VitualNodes,1000);

%Root mean square error
RMSE=zeros(1,1001);

for i=1:1001
    if i==1
        M=M_Optimized;
    else
        M=M_random(i-1,:);
    end
    J=Prepocessing_of_input(InputStream,M);
    xx=zeros(Num_of_VitualNodes,T);
    for it=1:T
        if it==1
            x0=zeros(Num_of_VitualNodes,1); %initialize the reservoir states
        else
            x0=xx(:,it-1);
        end
        xx(:,it)=update_reservior_states(tau,tstep,x0,gamma,J{it},zt(:,it),a,b,c);
    end
    %---------------------------------------------------------------------------
    %OnLine_training
    W_out=OnLine_training(xx(:,discarded_steps+1:T),training_data.y(:,discarded_steps+1:T),0.00000001);
    %---------------------------------------------------------------------------
    %Batch_training
%     W_out=Batch_training(xx(:,discarded_steps+1:T),training_data.y(:,discarded_steps+1:T),0.01);
    %---------------------------------------------------------------------------
    %Performance evaluation
    Output_stream=W_out'*xx(:,discarded_steps+1:T);
    result=CalcPerf(training_data.y(:,discarded_steps+1:T),Output_stream);
    RMSE(i)=result.NRMSE;
    fprintf('i=%6.4f',i);
    fprintf(' %10.6f',RMSE(i));
    fprintf('\n');
end
str=['Performance_comparison_on_5_lag_linear_memory_task.mat'];
save(str)
plot(RMSE);
%---------------------------------------------------------------------------
