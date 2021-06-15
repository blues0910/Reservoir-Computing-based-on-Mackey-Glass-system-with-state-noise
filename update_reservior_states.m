function [y] = update_reservior_states(lag,tstep,y0,gamma,J,z,a,b,c)
% 此处显示有关此函数的摘要
% 此处显示详细说明
%Model of Mackey-Glass system
%dx(t)=-b*x(t)+(a*(x(t-tau)))/(1+(x(t-tau))^c);
%
%Model of time delay reservoir based on Mackey-Glass system driven by time-dependent signals in the presence of state noise
%dx(t)=-b*x(t)+(a*(x(t-tau)+gamma*J+z))/(1+(x(t-tau)+gamma*J+z)^c);
% 
% gamma; input gain,
% z: additive Gaussian state noise,
% a: feedback gain,
% tau: time delay
% J: time-multiplexed input stream J=M*u, M is a mask vector or matrix
N=fix(lag/tstep);
if isempty(gamma)
    gamma=0;
end
if isempty(J)
    J=zeros(1,N);
end
yy=[y0 zeros(N,1)];
t=2;
for j=1:N 
    if j==1
        yy(j,t)=MG(@F,t,yy(N,t-1),yy(j,t-1),tstep,gamma,J(j),z(j),a,b,c);
    else
        yy(j,t)=MG(@F,t,yy(j-1,t),yy(j,t-1),tstep,gamma,J(j),z(j),a,b,c);
    end
end
% --------------------------------------
y=yy(:,2);
end
%--------------------------------------------------------------------------
function y=MG(varargin)
FuncHandle=varargin{1};
t=varargin{2};
x=varargin{3};
xh=varargin{4};
h=varargin{5};
gamma=varargin{6};
J=varargin{7};
z=varargin{8};
a=varargin{9};
b=varargin{10};
c=varargin{11};
k1=h*FuncHandle(t,x,xh,gamma,J,z,a,b,c);
k2=h*FuncHandle(t+h/2,x+k1/2,xh,gamma,J,z,a,b,c);
k3=h*FuncHandle(t+h/2,x+k2/2,xh,gamma,J,z,a,b,c);
k4=h*FuncHandle(t+h,x+k3,xh,gamma,J,z,a,b,c);
x=x+(k1+2*k2+2*k3+k4)/6;
y=x;
end
function v = F(varargin)
t=varargin{1};
y=varargin{2};
Z=varargin{3};
r=varargin{4};
J=varargin{5};
z=varargin{6};
a=varargin{7};
b=varargin{8};
c=varargin{9};
v=-b*y+(a*(Z+r*J+z))/(1+(Z+r*J+z)^c);
end

