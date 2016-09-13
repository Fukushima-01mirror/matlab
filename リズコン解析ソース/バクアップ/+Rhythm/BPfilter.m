function[y] = BPfilter(x)
kPath = char( strcat(cd, '\+Rhythm\BPFkeisuu_20130528.txt'));
k = csvread(kPath);
t_delay = k(1);
y = filter(k(2:end),1,x);
% y = zeros(length(x),1);
% for n = length(k):length(x)
%     for N= 1:length(k)
%         y(n) = y(n) + k(N) * x(n-N+1);
%     end
% end
xf = vertcat( y(t_delay+1:end) ,zeros(t_delay,1));
 
