function[PX,S0,P0,SIG,Flg] = PID(PXmax,PXmin,TSTEP,Kc,TI,TD,S1,S0,P1,P0,SIG,PX,Kg,Flg)
% PID control
% Nomenclature
% PXmax,PXmin   :����l�̍ő�E�ŏ��͈�
% TSTEP         :�v�Z�X�e�b�v
% Kc            :���Q�C��
% TI            :�ϕ�����
% TD            :��������
% S1            :�������̐��䂷��v�f�̐ݒ�l (���x�∳��)  S0:�O����
% P1            :�������̐��䂷��v�f�̒l   P0:�O����
% SIG           :�ϕ����a
% PX            :�������̐���Ɏg�p����v�f�̒l(��]���A�o���u�J�x�Ȃ�)
% CTRL          :����Ɏg�p����v�f�̐����
% Kg            :CTRL�̗ʂ𐧌䂷��v�f�̐ݒ�l�ɗ��Ƃ����ނ��߂̌W���B(-1��1)
% Flg           :�ݒ�l�ɕs�S������A�܂��͕s��Ő��䂪�����Ԃ��������Ȃ��Ă����ꍇ��SIG�����Z�b�g����
% example; Kc=0.06,TSTEP=1,TI=20,TD=0

% �O�����̐����
PX0 = PX;

if S1 > 0.001   %�ݒ�l���Ȃ��i���ʂ��Ȃ��j�ꍇ�A�o�͂�O�Ƃ���
    
    CTRL = Kc * ((S1-P1) + 1 / TI * (SIG) * TSTEP + TD * ((S1 - P1) - (S0 - P0)) / TSTEP);

    PX = PX0 + CTRL * Kg;

    % �O��������̕΍���5%�����Ƃ���
    if PX > PX0 + 0.05
        PX = PX0 + 0.05;
    elseif PX < PX0 - 0.05
        PX = PX0 - 0.05;
    end
    
    % ����ʂ͏㉺���l������
    if PX > PXmax
        PX = PXmax;
    elseif PX < PXmin
        PX = PXmin;
    end

else
    
    PX = 0.0;
    
end

SIG = SIG + S1 - P1;
S0 = S1;
P0 = P1;

% sekibunnjikannrisetto
time = 60;
for i = time:-1:2
        Flg(i) = Flg(i-1);
end
if S1 - P1 > 0
    Flg(1) = 1;
elseif S1 - P1 < 0
    Flg(1) = -1;
else
    Flg(1) = 0;
end
if Flg == 1
    SIG = 0;
    Flg = zeros(1,time);
end
if Flg == -1
    SIG = 0;
    Flg = zeros(1,time);
end


