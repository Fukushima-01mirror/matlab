function[zeroCrossTimes] = setZeroCrossCount(obj)
%input  obj ���@user.zeroCrossData
% output    �[���N���X�ԃs�[�N��


%�@�[���N���X�Ԃł̃s�[�N�񐔎擾
zeroCrossTimes = zeros(1,2);   %�@C1:�g�`�̑O�����̃s�[�N�񐔁@C2:�㔼���̃s�[�N��
zeroCrossTimes(1,1) = length( obj.peak(1).time );
for i = 2:length( obj.peak )
   zeroCrossTimes(i,1) = length( obj.peak(i).time );
   zeroCrossTimes(i,2) = length( obj.peak(i-1).time );
end

