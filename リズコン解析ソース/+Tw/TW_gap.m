function [A,B,gap] = TW_gap(X,Y)

%X����Ƃ���Y�̃M���b�v�𒲂ׂĂ������@

sa = zeros(length(Y),1);
gapAbs = zeros(length(X),2);
gapData = zeros(length(X),3);

%A�̊e�l�ɑ΂���Y���̍ŏ��l
for I=1:length(X)
    for J = 1: length(Y)
        sa(J,1) = Y(J,1) - X(I,1);
    end 
    [gapAbs(I,1),gapAbs(I,2)] = min(abs(sa));
    %����Q�߂�l�́CKyoku_timeA��index�����ł��ɂ��̒l�𒼐ڌv�Z
     
    gapData(I,1) = X(I,1);
    gapData(I,2) = Y(gapAbs(I,2),1);
    gapData(I,3) = Y(gapAbs(I,2),1)-X(I,1);
end

%�d���ӏ�����������
DelIndex = 0;

for I=2:length(X)
 
    if(gapData(I,2)==gapData(I-1,2))
        if abs(gapData(I,3)) > abs(gapData(I-1,3))
            DelIndex = [DelIndex I];
        else
            DelIndex = [DelIndex I-1];
        end
    end
  
end

if length(DelIndex) ~= 1
       hoge = DelIndex(1,2:length(DelIndex));
       gapData(hoge,:)=[];
end

A = gapData(:,1);
B = gapData(:,2);
gap = gapData(:,3);

return;