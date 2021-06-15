function [MC,FMC,Js] = Fisher_memory(T,tau,gamma,epsilon,equilibrium,a,b,c,tstep)
%Model of time delay reservoir based on Mackey-Glass system driven by time-dependent signals in the presence of state noise
%dx(t)=-b*x(t)+(a*(x(t-tau)+gamma*J+z))/(1+(x(t-tau)+gamma*J+z)^c);
% 
% gamma; input gain,
% epsilon: the noise variance
% a: feedback gain,
% tau: time delay
% T: the number of iterations

Num_of_VitualNodes=fix(tau/tstep);
Ak=cell(1,T);
x0=zeros(Num_of_VitualNodes,1)+equilibrium;
[A,B,C]=DxF(tstep,gamma,a,b,c,x0(:,1),Num_of_VitualNodes);
for it=1:T
    if it==1
        Ak{it}=A^0;
        Cov=C*C';
    else
        Ak{it}=Ak{it-1}*A;
        Cov=Ak{it}*(C*C')*Ak{it}'+Cov;
    end
end
Cov=epsilon*tstep.*Cov;
% ICov=inv(Cov);
FMs=cell(1,T);
Js=0;
for it=1:T
    FMs{it}=(B'*Ak{it}')/Cov*(Ak{it}*B);
    Js=FMs{it}+Js;
end
[V,D]=eig(Js);
V=real(V);
D=real(D);
[i,~]=find(D==max(max(D)));
M=V(:,i);
for it=1:T
    FMC(it)=M'*FMs{it}*M;
end
MC=sum(FMC);
end

%----------------------------------------------------------------------------
function [A,B,C]=DxF(d,gamma,a,b,c,x,N)
xp=x.^c;
g=a.*(1+(1-c).*xp)./((1+xp).^2);
eta=log(1+d*b);
tmp1=exp(-eta);
tmp2=b^(-1)*(1-tmp1).*g;
A=zeros(N,N);
for j=1:N
    if j~=N
        for i=j:N
            A(i,j)=tmp2(i)*tmp1^(i-j);
        end
    elseif j==N
        for i=1:N
            A(i,j)=tmp1^i;
        end
        A(N,N)=A(N,N)+tmp2(i);
    end
end

C=zeros(N,N);
for j=1:N
    for i=j:N
        C(i,j)=tmp2(i)*tmp1^(i-j);
    end
end

B=gamma.*C;
end

