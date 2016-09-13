function [osig,tau]=avar_func(data,column,tau0)
% function [sig,sig2,osig,msig,tsig,tau]=avar(y,tau0) 
% INPUTS: 
%  y = signal
%  tau0 = sampling period (s)
%
% OUTPUTS: 
%%% sig =  N samples STD DEV
%%% sig2 = Normal Allan STD DEV, 2 samples STD DEV.
% osig = Sigma(y)(tau) = Allan Standard Deviation with Overlapping estimate 
%%% msig = Modified Allan Standard Deviation 
%%% tsig = Time Allan Standard Deviation
% tau = measurement time (s).
%
% Copyright Alaa MAKDISSI 2003
% free for personal use only.

n=length(data);
jj=floor( log((n-1)/3)/log(2) );
tau = zeros(jj+1,1);
% sig = zeros(jj+1,column);
% sig2 = zeros(jj+1,column);
osig = zeros(jj+1,column);
% msig = zeros(jj+1,column);
% tsig = zeros(jj+1,column);

for k=1:column
    for j=0:jj
        fprintf('%d',column-k+1);
        m =2^j;
        tau(j+1) = m * tau0;
        D =zeros(1,n-m+1);
        for i=1:n-m+1
            D(i) = sum(data(i:i+m-1,k))/m;
        end

%         %N sample
%         sig(j+1)=std(D(1:m:n-m+1));
% 
%         %AVAR 
%         sig2(j+1)=sqrt(0.5*mean((diff(D(1:m:n-m+1)).^2)));

        %OVERAVAR
        z1=D(m+1:n+1-m);
        z2=D(1:n+1-2*m);
        u=sum((z1-z2).^2);
        osig(j+1,k)=sqrt(u/(n+1-2*m)/2);

%         %MVAR
%         u=zeros(1,n+2-3*m);
%         for L=0:n+1-3*m
%             z1=D(1+L:m+L);
%             z2=D(1+m+L:2*m+L);
%             u(L+1)=(sum(z2-z1))^2;
%         end
%         uu=mean(u);
%         msig(j+1)=sqrt(uu/2)/m;
% 
%         %TVAR
%         tsig(j+1)=tau(j+1)*msig(j+1)/sqrt(3);

    end
end

