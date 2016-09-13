 
function [D,Alpha1,n,F_n]=DFAouts_main(DATA,column)
% DATA should be a time series of length(DATA) greater than 2000,and of column vector.
%A is the alpha in the paper
%D is the dimension of the time series
%n can be changed to your interest
%n=1:1:100;
n=100:100:1000;
 n=n';

N1=length(n);
F_n=zeros(N1,column);
Alpha1= zeros(1,column);
A= zeros(2,column);
D= zeros(1,column);
for k=1:column
    for i=1:N1
         fprintf('%d',N1-i+1);
         F_n(i,k)=Rhythm.DFA(DATA(:,k),n(i),1);
    end

    % plot(log(n),log(F_n));
    % xlabel('n')
    % ylabel('F(n)')
    F = F_n(1:N1,k);
     A(:,k)=polyfit( log(n(1:N1)) , log( F(1:N1) ) , 1);
    Alpha1(1,k)=A(1,k);
     D(1,k)=3-A(1,k);
end