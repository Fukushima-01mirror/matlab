function[xf] = BPfilter_func2(x)
kPath = char( strcat(cd, '\+Rhythm\BPFkeisuu_20130509.txt'));
k = csvread(kPath);
t_delay = k(1);
y = filter(k(2:end),1,x);

% for n = length(k):length(x)
%     for N= 1:length(k)
%         y(n) = y + k(N) * x(n-N+1);
%     end
% end

xf = vertcat( y(t_delay+1:end) ,zeros(t_delay,1));
 
