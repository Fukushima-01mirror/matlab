function [coeff,score] = HMpca(X) 
%�听�����͊֐�
DATANUM = length(X);
Z = zeros(DATANUM,1);
prelambda = 0;

%���K���ɗp���镽�ϒl�ƕW���΍������߂�
mean1 = mean(X(:,1));
mean2 = mean(X(:,2));
std1 = std(X(:,1));
std2 = std(X(:,2));

for i = 1:DATANUM
X(i,1) = (X(i,1)-mean1)/std1;
X(i,2) = (X(i,2)-mean2)/std2;
end

%���K���������͒l�̑��֌W�������߂�
R = corrcoef(X);

%���חʏ����l�z��
W=[1;1];

%���חʒ������P

for j = 1:50
%     if j>1
%         R = R - lambda * W * Wonedash;
%     end
    Wonedash = R * W;
    Wsqdash = power(Wonedash,2);
    lambda = sqrt(sum(Wsqdash));
    if lambda == prelambda;
        Z = X * W;
        break
    else
        prelambda = lambda;
        W = Wonedash/prelambda;
    end
    coeff = W;
    score = Z;
end

%%