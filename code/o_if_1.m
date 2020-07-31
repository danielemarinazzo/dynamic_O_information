function o=o_if_1(Y,Y0,X)
%evaluates the o_information flow
% Y Nx1 target vector at time t+1 .Y0 Nx1 target at time t - X NxM drivers
% at time t
[N M]=size(X);
A=copnorm([Y Y0]);Y(1:N,1)=A(1:N);Y0(1:N,1)=A(N+1:2*N);
for i=1:M;X(:,i)=copnorm(X(:,i));end

o=-(M-1)*gccmi_ccc(Y,X,Y0);
for k=1:M
    X0=X;X0(:,k)=[];
    o=o+gccmi_ccc(Y,X0,Y0);
end