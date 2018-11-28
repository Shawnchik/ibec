function [dP] = Branch00(G,KrPp,KrEq,Vlv,Cv_max)
% �|���v�̂Ȃ��}�ɂ����āA���ʂ��爳�͑��������߂�T�u���[�`��
% [���͑���] = Branch0(����,�z�ǈ����W��,�@�툳���W��,�o���u�J�x)
% Nomenclature
% G         :����[m3/min]
% dP        :�}�̏o�������͍�[kPa]  
% KrPp      :�ǂ̈����W��[kPa/(m3/min)^2]
% KrEq      :�@��̈����W��[kPa/(m3/min)^2]
% Vlv       :�o���u�J�x(1:�S�J,0:�S��)
% Cv_max    :���ʌW���B�ق̃p�����[�^�B

% (�}�̈���) = (�ǈ���) + (�M������) + (�@�툳��) + (�o���u����)

% �و����v�Z�B���ʌW���̒�i�lCv_max�̓C�I���̉��x����قƃ����W�A�r���e�BR�̓o�^�t���C�o���u��20
% Cv_max = 2846;

% R = 20;
% R = 50;
R = 900;
Cv = Cv_max * R^(Vlv - 1);
dPVlv = - 1743 * (G * 1000 / 60)^2 / Cv^2;

dP = - KrPp * G^2 - KrEq * G^2 + dPVlv;
