function w_output= TrainFunc(xx,y_teach,Num_of_VitualNodes)
%LNEARREGRESS 此处显示有关此函数的摘要
%   此处显示详细说明
%Moore-Penrose pseudo-inverse------------------------------------------------------------------
x_MPP=pinv(xx);
w_output=x_MPP*y_teach';
%Tikhonov regularisation or ridge regression---------------------------------------------------
% w_output=pinv(tmpx'*tmpx+0.1*diag(var(tmpx)))*tmpx'*y_teach';
%----------------------------------------------------------------------------------------------
% w_output=Gradient_descent(tmpx,y_teach',Num_of_VitualNodes,0.1);%test code
%----------------------------------------------------------------------------------------------
% tmpxx=tmpx(:,2:end);%test code
% w_output=ridge(y_teach',tmpxx,1,0);%test code
%----------------------------------------------------------------------------------------------
% w_output=pinv(tmpx'*tmpx+0.1*eye(Num_of_VitualNodes))*tmpx'*y_teach';%test code
end