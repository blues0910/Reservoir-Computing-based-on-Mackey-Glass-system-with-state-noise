function v = NRMSE(y,yhat)
%NRMSE 此处显示有关此函数的摘要
%   此处显示详细说明
M=length(y);
tmp1=sum((y - yhat).^2);   % Mean Squared Error
tmp2=std(y)^2;
v= sqrt(tmp1/(M*tmp2));  % Normalised Root Mean Square Error
end

